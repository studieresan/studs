class Experience < ActiveRecord::Base
  KINDS = %w(education work extracurricular).freeze

  belongs_to :resume, inverse_of: :experiences

  default_scope order('end_date DESC')

  def duration
    start_date..end_date
  end

  def to_s
    title
  end
end
