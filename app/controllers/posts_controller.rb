class PostsController < ApplicationController
  respond_to :html
  before_filter :set_post, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource except: :feed

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
    respond_with(@post)
  end

  def edit
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

  def destroy
    @post.destroy
    respond_with(@post)
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end
end
