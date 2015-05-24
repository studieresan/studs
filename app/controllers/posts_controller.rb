class PostsController < ApplicationController
  respond_to :html
  before_filter :set_post, only: [:show, :edit, :update, :delete, :destroy]
  load_and_authorize_resource except: [:feed, :show]

  def feed
    @posts = Post.where(published: true).order("created_at DESC")
    respond_with @posts
  end

  def index
    @posts = Post.all
    respond_with(@posts)
  end

  def show
    respond_with(@post)
  end

  def new
    @post = Post.new
    @post_images = PostImage.order("id DESC").all
    respond_with(@post, @post_images)
  end

  def edit
    @post_images = PostImage.order("id DESC").all
    respond_with(@post_images)
  end

  def create
    @post = Post.new(params[:post])
    @post.save
    respond_with(@post)
  end

  def update
    @post.update_attributes(params[:post])
    respond_with(@post)
  end

  def delete
  end

  def destroy
    @post.destroy
    respond_with(@post)
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end
end
