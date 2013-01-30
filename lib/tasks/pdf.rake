namespace :pdf do
  directory 'tmp/cv'
  directory 'public/cv'

  task tex: :environment do
    Resume.includes(:experiences).all.each do |resume|
      File.open("tmp/cv/#{resume.slug}.tex", 'w') do |file|
        file.write resume.to_tex
      end
    end
  end

  task build: 'tmp/cv' do
    FileList['tmp/cv/*.tex'].each do |file|
      sh "cd tmp/cv && pdflatex #{File.basename(file)}"
    end
  end

  task publish: 'public/cv' do
    cp FileList['tmp/cv/*.pdf'], 'public/cv' unless FileList['tmp/cv/*.pdf'].empty?
  end

  task :clean do
    rm_rf 'tmp/cv'
  end

  task distclean: :clean do
    rm_rf 'public/cv/*.pdf'
  end
end

task pdf: ['pdf:tex', 'pdf:build']
