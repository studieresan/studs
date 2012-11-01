class ResumeFilter
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :name, :skill_list
  alias :n :name
  alias :n= :name=
  alias :s :skill_list
  alias :s= :skill_list=

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def skills
    return [] unless skill_list.present?
    ActsAsTaggableOn::TagList.from(skill_list).to_a
  end

  def resumes
    r = Resume.scoped
    r = r.where('name LIKE ?', "%#{name}%") if name.present?
    r = r.tagged_with(skills) if skill_list.present?
    r
  end

  def persisted?
    false
  end

  def valid?
    true
  end
end
