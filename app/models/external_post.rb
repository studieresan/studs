class ExternalPost < ActiveRecord::Base
  default_scope lambda { order("created_at DESC") }
  scope :from, lambda { |p| where(provider: p.to_s) }

  validates_presence_of :provider, :guid, :url, :title
  validates_uniqueness_of :guid
end
