class PostImagesController < ApplicationController
  respond_to :html

  load_and_authorize_resource

  def index
    @post_images = PostImage.order("id DESC").all
    respond_with(@post_images)
  end

  def new
    @post_image = PostImage.new
    respond_with(@post_image)
  end

  def create
    @post_image = PostImage.new(params[:post_image])
    @post_image.save
    if request.xhr?
      head :created, location: @post_image.image.url
    else
      redirect_to action: 'index'
    end
  end


  def destroy
    @post_image.destroy
    respond_with(@post_image)
  end

  private
    def set_post_image
      @post_image = PostImage.find(params[:id])
    end
end
