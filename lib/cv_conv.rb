module CVConverter

##### CV to .txt conversion #####

  def CVConverter.to_txt(cv)
"
Curriculum Vitae
================

Name: #{cv.name} <#{cv.email}>

Date of Birth: #{cv.date_of_birth}

Phone Number: #{cv.phone}

Keywords
========

#{cv.tags.sort.join ', '}

Education
=========

#{txt_section cv.education}

Experience
==========

#{txt_section cv.experience}

Extra-Curricular Activities
===========================

#{txt_section cv.other}

"
  end


  def CVConverter.txt_section(section)
    section.map { |text|
"* #{text.where} - #{text.location}

#{txt_what(text.what).gsub /^/, '  '}

".strip
    }.to_a.join "\n\n"
  end

  def CVConverter.txt_what(what)
    what.map { |thing|
"- #{thing.short}: #{thing.when}
   #{thing.description.gsub /^/, '  '}
".strip
    }.to_a.join "\n\n"
  end

##### CV to .tex conversion #####

  def CVConverter.to_tex(cv)
"
#{ IO.read 'cv_header.tex' }

\\def\\name {#{cv.name}}
\\makeatletter
\\date {#{Time.now.strftime '%F' }} \\let\\thedate\\@date
\\makeatother
\\title {stuDs, CV #{cv.name}}
\\author {\\name}

\\begin {document}

%{{{ Header

% Name
\\hspace{\\titleleft}\\parbox{\\titlefwidth}{
{\\theheader}\\vspace{-2mm}\\par
\\rule{\\titlefwidth}{1pt}\\vspace{2mm} % ruler
}

% Contact information
\\begin{tabular*}{\\textwidth}{@{}l l @{\\extracolsep{\\fill}} r @{}}
\\iconl{\\bf \\Large \\textborn} {\\bf Date of birth:} & #{cv.date_of_birth} \\\\
\\iconl{\\Telefon} {\\bf Phone number:} & #{cv.phone} \\\\
\\iconl{\\Letter} {\\bf Email address:} & \\href{mailto:#{cv.email}}{\\tt #{cv.email}} &
\\end{tabular*}

%}}}

\\section* {Keywords}

#{cv.tags.sort.join ', '}

\\section* {Education}

#{tex_section cv.education}

\\section* {Experience}

#{tex_section cv.experience}

\\section* {Extra-Curricular Activities}

#{tex_section cv.other}

#{ IO.read 'cv_footer.tex' }
"
  end


  def CVConverter.tex_section(section)
    section.map { |text|
"
\\theplace [, #{text.location}]{{}{#{text.where}}}

#{tex_what(text.what).gsub /^/, '  '}

".strip
    }.to_a.join "\n\n"
  end

  def CVConverter.tex_what(what)
    what.map { |thing|
"\\thework{#{escape_latex thing.short}}{\\mbox{#{escape_latex thing.when}}}
   #{escape_latex(thing.description).gsub /^/, '  '}
".strip
    }.to_a.join "\n\n"
  end

  def CVConverter.escape_latex(text)
    text.gsub(/&/, '\\\\&').gsub(/%/, '\\\\%').gsub(/\$/, '\\\\$')
  end
end


