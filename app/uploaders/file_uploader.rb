class FileUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.id}"
  end

  def extension_black_list
    %w(js php aspx asp)
  end
end
