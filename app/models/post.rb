class Post < ActiveRecord::Base
  attr_accessible :content, :published, :title
end
