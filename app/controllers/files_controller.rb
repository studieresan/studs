class FilesController < ApplicationController
  before_filter :authorize

  def index
    @files = DownloadableFile.all
  end

  def create
  end

  def delete
    @file = DownloadableFile.new(params[:id])
  end

  def destroy
  end

  private

  def authorize
    authorize!(params[:action], :files)
  end
end
