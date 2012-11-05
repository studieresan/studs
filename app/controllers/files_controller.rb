class FilesController < ApplicationController
  before_filter :authorize

  def index
    @files = DownloadableFile.all
  end

  def create
    if DownloadableFile.store(params[:file])
      flash[:notice] = t('files.flash.success')
    else 
      flash[:alert] = t('files.flash.error')
    end
    redirect_to action: 'index'
  end

  def delete
    @file = DownloadableFile.new(params[:id])
  end

  def destroy
    DownloadableFile.delete(params[:id])
    flash[:notice] = t('files.flash.deleted')
    redirect_to action: 'index'
  end

  private

  def authorize
    authorize!(params[:action].to_sym, :files)
  end
end
