class User < ActiveRecord::Base
  ROLES = %w(organization student admin).freeze

  has_one :resume

  authenticates_with_sorcery!

  attr_protected :role, as: :admin

  validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validates :email, presence: true

  # Role scopes
  ROLES.each.with_index do |role, val|
    scope "#{role}s".to_sym, lambda { where(role: val) }
  end

  def organization?
    role < 1
  end

  def student?
    role > 0
  end

  def admin?
    role > 1
  end

  def to_s
    login
  end
end
