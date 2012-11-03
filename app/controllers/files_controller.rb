class FilesController < ApplicationController
  before_filter :authorize

  def index
    @files = Dir[File.join(uploads_path, '*')].map { |f| file_info(f) }
  end

  def show
  end

  def new
  end

  def create
  end

  def destroy
  end

  private

  def authorize
    authorize!(params[:action], :files)
  end

  def file_info(file)
    parts = File.split(file)
    stat = File.stat(file)
    {
      path: parts[0],
      name: parts[1],
      size: stat.size,
      mtime: stat.mtime,
    }
  end

  def uploads_path
    File.join('public', FileUploader::DIRECTORY)
  end
end
