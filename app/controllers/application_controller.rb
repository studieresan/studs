class ApplicationController < ActionController::Base
  helper MenuHelper

  before_filter :set_locale
  after_filter :flash_to_xhr_headers

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    save_return_url
    redirect_to login_url, :alert => t('flash.unauthorized_html')
  end

  unless Rails.application.config.consider_all_requests_local
    rescue_from ActionController::RoutingError, with: :not_found
    rescue_from ActionController::UnknownController, with: :not_found
    rescue_from ::AbstractController::ActionNotFound, with: :not_found
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
  end

  def not_found(exception = nil)
    @exception = exception

    respond_to do |f|
      f.html { render 'errors/not_found', status: 404, layout: 'application' }
      f.all { head 404 }
    end
  end
  
  protected

  def current_role
    logged_in? ? current_user.role.to_sym : nil
  end

  def not_authenticated
    redirect_to login_path
  end

  def save_return_url(url = nil)
    url = request.fullpath if url.nil?
    session[:return_to_url] = url
  end

  def flash_to_xhr_headers
    return if !request.xhr? || flash.empty?
    flash_json = Hash[flash.map{|k,v| [k,ERB::Util.h(v)] }].to_json
    response.headers['X-Messages'] = flash_json
    flash.discard
  end

  def custom_log_error(err)
    if err.kind_of? Exception
      Rails.logger.error "ERROR(#{err.class}): #{err.message}\nSOURCE: #{err.backtrace.first}"
    else
      Rails.logger.error("ERROR: #{err}")
    end
  end

  # I18n language selection
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # URL options
  def default_url_options(options={})
    {
      locale: I18n.locale,
      trailing_slash: true,
    }.merge(options)
  end
end
