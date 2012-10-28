class Resume < ActiveRecord::Base
  MASTERS = %w(bsb csc dtn dis ine int com hci mai2 mth meg nss sed stek syb skk scr tls).freeze

  belongs_to :user
  has_many :experiences, inverse_of: :resume, dependent: :destroy

  attr_protected :user, as: :admin

  validates_presence_of :name, :email

  acts_as_taggable_on :skills

  def masters_name
    I18n.t("masters.#{self.masters}")
  end

  def person_age
    (Time.now.to_s(:number).to_i - self.birthdate.to_time.to_s(:number).to_i) / 10e9.to_i
  end

  def to_s
    name
  end
end
