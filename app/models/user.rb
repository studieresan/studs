class User < ActiveRecord::Base
  ROLES = %w(organization student admin).freeze
  STUDENT_ROLES = (ROLES - %w(organization)).freeze

  has_one :resume

  authenticates_with_sorcery!

  # Credentials email hooks
  before_save :temporarily_store_password_for_mail
  after_save :send_credentials_mail_if_specified

  # Only admins should be able to change username and role
  attr_protected :login, :role, as: [:default, :student, :organization]

  validates :login, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :email, presence: true, format: { with: /[\w.%+-]+@[\w.-]+\.[a-z]{2,4}/i }
  validates_inclusion_of :role, in: ROLES

  validates :password, presence: true, length: { minimum: 3 }, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_presence_of :password_confirmation, if: :password_required?

  auto_strip_attributes :login, :email, :name, squish: true

  # Scopes and inclusion testing for each user role.
  (ROLES - %w(student)).each do |role|
    scope "#{role}s".to_sym, lambda { where(role: role) }
    define_method "#{role}?".to_sym, lambda { self.role == role }
  end

  default_scope order('login ASC')

  # The student role is special since it includes admins as well.
  scope :students, lambda { where(role: STUDENT_ROLES) }
  def student? # admins are also students
    STUDENT_ROLES.include?(role)
  end

  def to_s
    name.present? ? name : login
  end

  def to_param
    login
  end

  # Virtual attribute which controls credentials mail sending after save.
  attr_writer :send_credentials_mail
  def send_credentials_mail
    %w(true 1 on).include?(@send_credentials_mail.try(:to_s))
  end

  private

  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end

  def temporarily_store_password_for_mail
    @plain_password = password
  end

  def send_credentials_mail_if_specified
    pass, @plain_password = @plain_password, nil
    return unless send_credentials_mail
    raise "Can't send credentials mail without specifying a new password" if pass.blank?
    UserMailer.credentials_mail(self, pass).deliver
  end
end
