class DownloadableFile
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  DIRECTORY = 'uploads'.freeze

  attr_reader :url, :name, :dir, :size, :mtime

  def self.all
    Dir[File.join(uploads_path, '*')].map do |f|
      DownloadableFile.new(f, true)
    end
  end

  def self.uploads_path
    File.join('public', DIRECTORY)
  end

  def self.path_for(name)
    name = File.basename(name)
    raise "Invalid file name: #{name}" if %w(. ..).include?(name)
    File.join(uploads_path, name)
  end

  def self.find_by_param(name)
    path = path_for(name)
    raise ActiveRecord::RecordNotFound unless File.file?(path)
    new(name)
  end

  def self.store(upload)
    file = upload['file']
    return false if file.nil?
    name = upload['name'].present? ? upload['name'] : file.original_filename
    path = path_for(name)
    File.open(path, 'wb') { |f| f.write(file.read) }
    path
  end

  def self.delete(name)
    path = path_for(name)
    return false unless File.file?(path)
    File.delete(path)
  end

  def initialize(name, is_path = false)
    name = self.class.path_for(name) unless is_path
    raise ActiveRecord::RecordNotFound unless File.file?(name)
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
