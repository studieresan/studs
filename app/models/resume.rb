class Resume < ActiveRecord::Base
  MASTERS = %w(bsb csc dtn dis ine int com hci mai2 mth meg nss sed stek syb skk scr tls).freeze

  belongs_to :user
  has_many :experiences, inverse_of: :resume, dependent: :destroy

  attr_protected :user, as: :admin

  validates_presence_of :name, :email

  acts_as_ordered_taggable_on :skills

  def self.existing_skills
    self.tag_counts_on(:skills).order("count DESC").map(&:name)
  end

  # Returns all skills for this resume excluding the ones provided.
  # list can be a String, TagList or Array.
  def skills_except(list)
    list = ActsAsTaggableOn::TagList.from(list) if list.is_a?(String)
    list = list.to_a if list.is_a?(ActsAsTaggableOn::TagList)
    list ||= []
    skills.map(&:name) - list
  end

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
