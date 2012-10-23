class Experience < ActiveRecord::Base
  belongs_to :resume, inverse_of: :experiences

  attr_accessible :start_time, :end_time
  attr_accessible :kind, :organization, :location, :title, :description

  def duration
    start_time..end_time
  end

  def to_s
    title
  end
end
