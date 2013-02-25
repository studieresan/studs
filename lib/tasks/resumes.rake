namespace :resumes do
  directory 'tmp/resumes'

  task build: :environment do
    Resume.all.each do |resume|
      %w(en sv).each do |lang|
        tex = TexResume.new(resume, lang)
        path = tex.save true
        if path[0]
          puts "> #{path[0]}"
        else
          puts "! #{path[0]}\n" + ("=" * 60)
          puts path[1]
          puts "=" * 60
        end
      end
    end
  end

  task :clean do
    rm_rf 'tmp/resumes/*' unless FileList['tmp/resumes/*'].empty?
  end
end

task resumes: ['resumes:clean', 'resumes:build']
