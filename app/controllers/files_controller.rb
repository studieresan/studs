class FilesController < ApplicationController
  before_filter :authorize

  def index
    @files = DownloadableFile.all
  end

  def create
    session[:return_to] ||= request.referer
    file = DownloadableFile.new(params[:file])
    if file.exists? && current_ability.cannot?(:update, :files)
      flash[:alert] = t('files.flash.cannot_replace')
    elsif file.complete_upload
      flash[:notice] = t('files.flash.success')
    else 
      flash[:alert] = t('files.flash.error')
    end
    redirect_to session.delete(:return_to)
  end

  def delete
    @file = DownloadableFile.new(params[:id])
    raise ActiveRecord::RecordNotFound unless @file.exists?
  end

  def destroy
    DownloadableFile.new(params[:id]).delete
    flash[:notice] = t('files.flash.deleted')
    redirect_to action: 'index'
  end

  private

  def authorize
    authorize!(params[:action].to_sym, :files)
  end
end
