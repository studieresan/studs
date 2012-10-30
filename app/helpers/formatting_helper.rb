module FormattingHelper
  def paragraphize(string)
    # Trim whitespace
    string.gsub!(/\A\s+|\s+\Z/, '');
    ('<p>' + string.split(/\n{2,}/).join('</p><p>') + '</p>').html_safe
  end
end
