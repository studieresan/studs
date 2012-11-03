class UsersController < ApplicationController
  respond_to :html
  responders :flash, :collection

  load_and_authorize_resource

  before_filter :review_authorization

  def index
  end

  def show
  end

  def new
  end

  def create
    @user = User.new(params[:user])
    @user.save
    respond_with @user
  end

  def edit
  end

  def update
    @user.update_attributes(params[:user])
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
