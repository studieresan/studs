class Post < ActiveRecord::Base
  has_one :post_image, dependent: :destroy
  accepts_nested_attributes_for :post_image,
    :allow_destroy => true,
    :reject_if     => :all_blank
  default_scope lambda { order("updated_at DESC")}
  attr_accessible :content, :published, :title, :post_image_attributes

  def to_s
  	title
  end
end
