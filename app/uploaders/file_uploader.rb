class FileUploader < CarrierWave::Uploader::Base
  DIRECTORY = "uploads".freeze

  storage :file

  def store_dir
    DIRECTORY
  end

  def extension_black_list
    %w(js php aspx asp)
  end
end
