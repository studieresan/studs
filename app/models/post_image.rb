class PostImage < ActiveRecord::Base
  attr_accessible :image
  mount_uploader :image, PostImageUploader
end
