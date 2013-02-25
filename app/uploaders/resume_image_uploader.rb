class ResumeImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  storage :file

  def store_dir
    "uploads/resumes/image"
  end

  def filename
    ("#{model.slug}.#{file.extension}" || original_filename) if original_filename
  end

  process resize_to_limit: [400, 500]

  version :small do
    process resize_to_limit: [80, 100]
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end
