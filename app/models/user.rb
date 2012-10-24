class User < ActiveRecord::Base
  ROLES = %w(organization student admin).freeze

  has_many :resumes

  authenticates_with_sorcery!

  attr_accessible :login, :email, :name, :password, :password_confirmation

  validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validates :email, presence: true

  # Define helper methods like student? and admin?,
  # returning if the user belongs to that group (or a higher one).
  ROLES.each.with_index do |role, val|
    define_method("#{role}?".to_sym) { self.role >= val }
    scope "#{role}s".to_sym, lambda { where(role: val) }
  end
end
