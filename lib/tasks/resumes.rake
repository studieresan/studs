namespace :resumes do
  directory 'tmp/resumes'
  directory 'public/resumes'

  task build: :environment do
    Resume.all.each do |resume|
        tex = TexResume.new(resume, @url, 'en')
        path = tex.save true
        if path[0]
          puts "> #{tex.base_name}.pdf"
        else
          puts "! #{tex.base_name}.pdf\n" + ("=" * 60)
          puts path[1]
          puts "=" * 60
        end
    end
  end

  task publish: 'public/resumes' do
    cp FileList['tmp/resumes/*.pdf'], 'public/resumes' unless FileList['tmp/resumes/*.pdf'].empty?
  end

  task :clean do
    rm_rf 'tmp/resumes/*' unless FileList['tmp/resumes/*'].empty?
  end

  task distclean: :clean do
    rm_rf 'public/resumes/*.pdf' unless FileList['resumes/resumes/*.pdf'].empty?
  end
end

task resumes: 'resumes:build'
