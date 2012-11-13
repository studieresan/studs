class UsersController < ApplicationController
  respond_to :html
  responders :flash, :collection

  load_and_authorize_resource except: [:create], find_by: :login

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
    authorize! :create, @user
    @user.save
    respond_with @user
  end

  def edit
  end

  def update
    begin
      @user.assign_attributes(params[:user], as: current_role)
      @user.save
      respond_with @user, location: return_url
    rescue RuntimeError
      flash[:alert] = I18n.t('users.credentials_mail.' +
        (params[:user][:password].blank? ? 'cant_sent_without_password' : 'sending_failed'))
      render 'edit'
    end
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
