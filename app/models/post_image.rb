class PostImage < ActiveRecord::Base
  belongs_to :post
  attr_accessible :image
  mount_uploader :image, PostImageUploader
end
