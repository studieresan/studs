class ZipController < ApplicationController
  require 'rubygems'
  require 'zip'

  OUTPUT_DIR    = File.join(Rails.root, 'tmp', 'resumes')

  def index
    resumes = Resume.all
    zipfile_name = File.join(OUTPUT_DIR, "all_resumes.zip")
    
    File.delete(zipfile_name) if File.exists?(zipfile_name)
    Dir.mkdir(OUTPUT_DIR) unless File.directory?(OUTPUT_DIR)

    Dir.chdir OUTPUT_DIR do
      Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
        resumes.each do |resume|
          tex = TexResume.new(resume, I18n.locale)
          path = tex.save

          zipfile.add("#{tex.base_name}.pdf", path[0])
        end
      end
    end
    send_file zipfile_name, filename: "studs.zip", type: 'application/zip'
  end

end
