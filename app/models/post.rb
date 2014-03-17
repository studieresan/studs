class Post < ActiveRecord::Base
  default_scope lambda { order("created_at DESC")}
  attr_accessible :content, :published, :title

  def to_s
  	title
  end
end
