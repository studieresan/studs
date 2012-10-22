class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessible :login, :email, :name, :password, :password_confirmation

  validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validates :email, presence: true
end
