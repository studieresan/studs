class User < ActiveRecord::Base
  ROLES = %w(organization student admin).freeze
  STUDENT_ROLES = (ROLES - %w(organization)).freeze

  has_one :resume

  authenticates_with_sorcery!

  after_save :send_credentials_mail_if_specified

  # Only admins should be able to change username and role
  attr_protected :login, :role, as: [:default, :student, :organization]

  validates :login, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :email, presence: true
  validates_inclusion_of :role, in: ROLES

  validates :password, presence: true, length: { minimum: 3 }, if: :password
  validates_confirmation_of :password, if: :password
  validates_presence_of :password_confirmation, if: :password

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

  # Virtual attribute which controls credentials mail sending after save.
  attr_writer :send_credentials_mail
  def send_credentials_mail
    %w(true 1 on).include?(@send_credentials_mail.try(:to_s)) || false
  end

  private

  def send_credentials_mail_if_specified
    UserMailer.credentials_mail(self).deliver
  end
end
