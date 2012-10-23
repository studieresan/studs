class SessionController < ApplicationController
  def new
    redirect_back_or_to index_url if logged_in?
  end

  def create
    user = login(params[:login], params[:password], params[:remember])
    if user
      redirect_back_or_to index_url
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
