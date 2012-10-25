class Resume < ActiveRecord::Base
  belongs_to :user
  has_many :experiences, inverse_of: :resume, dependent: :destroy

  attr_protected :user, as: :admin

  acts_as_taggable_on :skills

  def to_s
    name
  end
end
