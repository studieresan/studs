class UsersController < ApplicationController
  respond_to :html
  responders :flash, :collection

  load_and_authorize_resource

  def index
  end

  def me
    @user = current_user
    render 'edit'
  end

  def new
  end

  def create
    @user = User.new(params[:user], as: current_role)
    @user.save
    respond_with @user
  end

  def edit
  end

  def update
    @user.update_attributes(params[:user])
    @user.save
    respond_with @user, location: return_url
  end

  def delete
  end

  def destroy
    @user.destroy
    respond_with @user, location: users_path
  end

  private

  def return_url
    current_role == :admin ? users_path : me_users_path
  end
end
