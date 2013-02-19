namespace :resumes do
  directory 'tmp/resumes'
  directory 'public/resumes'

  task tex: :environment do
    Resume.includes(:experiences).all.each do |resume|
      File.open("tmp/resumes/#{resume.slug}.tex", 'w') do |file|
        file.write resume.to_tex
      end
    end
  end

  task build: 'tmp/resumes' do
    FileList['tmp/resumes/*.tex'].each do |file|
      sh "cd tmp/resumes && pdflatex #{File.basename(file)}"
    end
  end

  task publish: 'public/resumes' do
    cp FileList['tmp/resumes/*.pdf'], 'public/resumes' unless FileList['tmp/resumes/*.pdf'].empty?
  end

  task :clean do
    rm_rf 'tmp/resumes'
  end

  task distclean: :clean do
    rm_rf 'public/resumes/*.pdf'
  end
end

task pdf: ['resumes:tex', 'resumes:build']
