module ZipHelper
	OUTPUT_DIR    = File.join(Rails.root, 'tmp', 'resumes')

	def create_zip(resumes)
		zipfile_name = File.join(OUTPUT_DIR, "all_resumes.zip")
	    out = 'error'

		File.delete(zipfile_name) if File.exists?(zipfile_name)
	    Dir.mkdir(OUTPUT_DIR) unless File.directory?(OUTPUT_DIR)
	    Dir.chdir OUTPUT_DIR do
	    	Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
				resumes.each do |resume|
					tex = TexResume.new(resume, I18n.locale)
					path = tex.save

					zipfile.add("#{tex.base_name}.pdf", path[0])
			  	end
				zipfile.get_output_stream("myFile") { |os| os.write "myFile contains just this" }
			end
	      
	      return zipfile_name
	    end

	    return nil
	end
end