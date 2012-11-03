class UsersController < ApplicationController
  respond_to :html, :xml
  responders :flash, :collection

  before_filter :review_authorization

  def index
    @users = User.scoped
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.save
    respond_with @user
  end

  private

  def review_authorization
    unless logged_in?
      save_return_url
      render 'resumes/logged_out'
      return 
    end
  end
end
