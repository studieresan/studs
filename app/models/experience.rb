class Experience < ActiveRecord::Base
  KINDS = %w(education work extracurricular).freeze

  belongs_to :resume, inverse_of: :experiences

  def duration
    start_time..end_time
  end

  def to_s
    title
  end
end
