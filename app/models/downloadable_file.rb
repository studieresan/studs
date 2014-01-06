class DownloadableFile
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  DIRECTORY = 'uploads'.freeze

  attr_reader :url, :name, :path, :size, :mtime

  def self.all
    Dir[File.join(uploads_path, '*.*')].map { |f|
      DownloadableFile.new(File.basename(f))
    }.sort_by(&:name)
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
    obj = new(name)
    raise ActiveRecord::RecordNotFound unless obj.exists?
    obj
  end

  def initialize(name)
    if name.kind_of?(Hash) # form paramaters submitted?
      @name, @upload = name[:name], name[:file]
      if @upload.is_a?(ActionDispatch::Http::UploadedFile)
        @name = @upload.original_filename unless @name.present?
      end
    else # file name provided
      @name = name
    end

    @path = self.class.path_for(@name)
    @url = @path.sub(/\A\/?public/, '')
    self.stat if exists?
    #raise ActiveRecord::RecordNotFound unless self.class.exists?(name, true)
  end

  def complete_upload
    return false unless @upload
    Dir.mkdir(DownloadableFile.uploads_path) unless File.directory?(DownloadableFile.uploads_path)
    File.open(@path, 'wb') { |f| f.write(@upload.read) }
    @upload = nil
    true
  end

  def delete
    return false unless exists?
    File.delete(@path)
    true
  end

  def exists?
    File.file?(@path)
  end

  def stat
    return @stat if @stat
    @stat = File.stat(@path)
    @size = @stat.size
    @mtime = @stat.mtime
    @stat
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
