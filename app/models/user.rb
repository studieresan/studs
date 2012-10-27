class User < ActiveRecord::Base
  ROLES = %w(organization student admin).freeze
  STUDENT_ROLES = (ROLES - %w(organization)).freeze

  has_one :resume

  authenticates_with_sorcery!

  attr_protected :role, as: :admin

  validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validates :email, presence: true
  validates_inclusion_of :role, in: ROLES

  # Scopes and inclusion testing for each user role.
  (ROLES - %w(student)).each do |role|
    scope "#{role}s".to_sym, lambda { where(role: role) }
    define_method "#{role}?".to_sym, lambda { self.role == role }
  end

  # The student role is special since it includes admins as well.
  scope :students, lambda { where(role: STUDENT_ROLES) }
  def student? # admins are also students
    STUDENT_ROLES.include?(role)
  end

  def to_s
    login
  end
end
