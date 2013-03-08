class ExternalPost < ActiveRecord::Base
  default_scope lambda { order("pubdate DESC").where(deleted: false ) }
  scope :from, lambda { |p| where(provider: p.to_s) }

  validates_presence_of :provider, :guid, :url, :title, :pubdate
  validates_uniqueness_of :guid
end
