class Event < ActiveRecord::Base
  attr_accessible :description, :end_date, :location, :start_date, :title, :charts, :quotes
  has_and_belongs_to_many :users

  def to_s
    title
  end
end
