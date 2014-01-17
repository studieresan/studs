class FilesController < ApplicationController
  before_filter :authorize

  def index
    @files = DownloadableFile.all
  end

  def create
    file = DownloadableFile.new(params[:file])
    if file.exists? && current_ability.cannot?(:update, :files)
      flash[:alert] = t('files.flash.cannot_replace')
    elsif file.complete_upload
      if request.xhr?
        flash[:notice] = "Access file at #{file.url}"
        head :created, location: file.url
      else
        flash[:notice] = t('files.flash.success')
      end
    else
      flash[:alert] = t('files.flash.error')
    end

    unless request.xhr?
      redirect_to action: 'index'
    end
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
