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
    # TODO
  end

  task publish: :build do
    cp 'tmp/cv/*.pdf', 'public/cv' unless FileList['tmp/cv/*.pdf'].empty?
  end

  task :clean do
    rm_rf 'tmp/cv'
  end

  task distclean: :clean do
    rm_rf 'public/cv/*.pdf'
  end
end

task pdf: 'pdf:publish'
