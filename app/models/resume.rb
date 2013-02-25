class Resume < ActiveRecord::Base
  MASTERS = %w(bsb csc dtn dis ine int com hci mai2 mth meg nss sed stek syb skk scr tls civ_ing).freeze

  belongs_to :user
  has_many :experiences, inverse_of: :resume, dependent: :destroy

  attr_protected :user, as: :admin

  validates :name, presence: true, length: { minimum: 4 }
  validates :email, presence: true, format: { with: /[\w.%+-]+@[\w.-]+\.[a-z]{2,4}/i }

  auto_strip_attributes :name, :email, :linkedin_url, :phone, :presentation, squish: false

  #validates :slug, presence: true, uniqueness: true
  acts_as_url :name, url_attribute: :slug, sync_url: true

  acts_as_ordered_taggable_on :skills

  accepts_nested_attributes_for :experiences, allow_destroy: true, reject_if: :all_blank

  mount_uploader :image, ResumeImageUploader

  def self.existing_skills
    self.tag_counts_on(:skills).order("count DESC").map(&:name)
  end

  def experiences_by_kind
    experiences.to_a.group_by(&:kind)
  end

  # Returns all skills for this resume excluding the ones provided.
  # list can be a String, TagList or Array.
  def skills_except(list)
    list = ActsAsTaggableOn::TagList.from(list) if list.is_a?(String)
    list = list.to_a if list.is_a?(ActsAsTaggableOn::TagList)
    list ||= []
    skills.map(&:name) - list
  end

  def person_age
    (Time.now.to_s(:number).to_i - self.birthdate.to_time.to_s(:number).to_i) / 10e9.to_i
  end

  def to_s
    name
  end

  def to_param
    slug
  end
end
