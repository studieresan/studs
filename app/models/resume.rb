class Resume < ActiveRecord::Base
  belongs_to :user
  has_many :experiences, inverse_of: :resume, dependent: :destroy

  attr_protected :user, as: :admin

  acts_as_taggable_on :skills

  def person_age
    (Time.now.to_s(:number).to_i - self.birthdate.to_time.to_s(:number).to_i) / 10e9.to_i
  end

  def to_s
    name
  end
end
