class Resume < ActiveRecord::Base
  belongs_to :user

  attr_accessible :name, :birthdate, :email, :phone, :address

  acts_as_taggable_on :skills
end
