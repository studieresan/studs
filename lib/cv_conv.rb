require 'erb'

module CVConverter
  def self.escape_latex(text)
    text.gsub!(/\&/, '\\\\&')
    text.gsub!(/%/, '\\\\%')
    text.gsub!(/\$/, '\\\\$')
  end

  def self.to_tex(cv)
    [cv.education, cv.experience, cv.other].each do |group|
      group.each do |thing|
        escape_latex thing.where
        escape_latex thing.location
        thing.what.each do |subthing|
          escape_latex subthing.short
          escape_latex subthing.description
        end
      end
    end
    ERB.new(File.open('cv-tex.erb').read()).result(cv.send :binding)
  end
end
