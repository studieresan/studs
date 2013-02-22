class TexResume
  include ActionView::Helpers::TextHelper, I18nHelper, FormattingHelper,
    ActionView::Helpers::TranslationHelper

  attr_reader :r, :url, :lang
  attr_accessor :output_dir

  def initialize(resume, url, lang = 'en')
    @r = resume
    @url = url
    @lang = lang

    @output_dir = File.join(Rails.root, 'tmp', 'resumes')

    @template_path = File.join(Rails.root, 'app', 'views', 'resumes', 'show.tex.erb')
    @logo_path = File.join(Rails.root, 'public', 'uploads', 'logo.pdf')
    #@logo_path = nil unless File.size?(@logo_path)
  end

  def base_name
    "#{@r.slug}.#{@lang}"
  end

  def pdf_path
    File.join(@output_dir, "#{base_name}.pdf")
  end

  # Renders the resume in TeX format and returns the generated TeX code.
  def to_tex
    ERB.new(IO.read(@template_path)).result(binding)
  end

  # Renders the resume in TeX and compiles it to PDF (unless there's an existing
  # copy of it newer than the last modification time of the model).
  # Returns an absolute path to the compiled PDF if successful, nil otherwise.
  def to_pdf(force_render = false)
    tex_path = File.join(@output_dir, "#{base_name}.tex")
    out = 'error'

    if !force_render && File.size?(pdf_path) && File.mtime(pdf_path) > @r.updated_at
      return pdf_path, 'cached'
    end

    Dir.mkdir(@output_dir) unless File.directory?(@output_dir)
    Dir.chdir @output_dir do
      File.open(tex_path, 'w') do |file|
        file.write to_tex
      end

      File.unlink(pdf_path) if File.file?(pdf_path)

      # Compile tex source twice (to sync AUX file and stuff)
      out = `pdflatex #{tex_path} && pdflatex #{tex_path}`

      return pdf_path, out if File.size?(pdf_path)
    end

    return nil, out
  end

  alias :save :to_pdf

  # Escapes special TeX character sequences in a string.
  def htex(str)
    return str unless str.kind_of? String
    str.blank? ? '' : str.gsub(/\&/, '\\\\&').gsub(/%/, '\\\\%').gsub(/\$/, '\\\\$')
  end
end

module I18n
  class MissingTranslation
    def html_message
      "[#{keys.join('.')}]"
    end
  end
end
