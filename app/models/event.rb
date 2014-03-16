class Event < ActiveRecord::Base
  attr_accessible :description, :location, :start_date, :charts, :quotes
  has_and_belongs_to_many :users

  def to_s
    title
  end
end
