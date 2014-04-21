class ExternalPostsController < ApplicationController
  before_filter :authorize, except: :index

  def index
    @entries = ExternalPost.from('instagram')
  end

  def delete
    model_name = t('models.the.external_post')
    
    # Soft delete external post to prevent it from reappearing
    if ExternalPost.update(params[:id], deleted: true)
      flash.notice = t('flash.actions.destroy.notice', resource_name: model_name)
    else
      flash.notice = t('flash.actions.destroy.alert', resource_name: model_name)
    end

    redirect_to root_url
  end

  private

  def authorize
    authorize!(params[:action].to_sym, :files)
  end
end
