class DownloadableFile
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_reader :url, :name, :dir, :size, :mtime

  def self.all
    Dir[File.join(uploads_path, '*')].map do |f|
      DownloadableFile.new(f, true)
    end
  end

  def self.uploads_path
    File.join('public', FileUploader::DIRECTORY)
  end

  def self.path_for(name)
    File.join(uploads_path, name)
  end

  def self.find_by_param(name)
    path = path_for(name)
    raise ActiveRecord::RecordNotFound unless File.exists?(path)
    new(name)
  end

  def initialize(name, is_path = false)
    name = self.class.path_for(name) unless is_path
    stat = File.stat(name)
    parts = File.split(name)
    @url = name.sub(/\A\/?public/, '')
    @dir = parts[0]
    @name = parts[1]
    @size = stat.size
    @mtime = stat.mtime
  end

  def to_s
    @name
  end

  def to_param
    @name
  end

  def persisted?
    false
  end

  def valid?
    true
  end
end
