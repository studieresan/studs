class SessionController < ApplicationController
  def new
    redirect_back_or_to index_url if logged_in?
  end

  def create
    user = login(params[:login], params[:password], params[:remember])

    if user and user.organization?
      save_return_url
      if request.referer.end_with? login_path
        redirect_to intro_users_path
      else
        redirect_back_or_to intro_users_path
      end
    elsif user
      save_return_url
      redirect_back_or_to me_users_path
    else
      flash.now.alert = I18n.t('session.invalid_credentials')
      render :new
    end
  end

  def destroy
    logout if current_user
    redirect_to index_url
  end
end
