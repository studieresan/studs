module FormattingHelper
  # Returns a string split into HTML paragraph tags.
  def paragraphize(string)
    # Trim whitespace
    string = string.gsub(/\A\s+|\s+\Z/, '').gsub(/\r\n?/, "\n")
    ('<p>' + string.split(/\n{2,}/).join('</p><p>') + '</p>').html_safe
  end

  # Formats a string through Redcarpet Markdown.
  def markdown(string)
    @markdown_renderer ||= Redcarpet::Markdown.new(
      Redcarpet::Render::XHTML.new(
        hard_wrap: true,
        safe_links_only: true,
        no_images: true,
        filter_html: true
      ),
      tables: false,
      fenced_code_blocks: false,
      autolink: true,
      strikethrough: true,
      superscript: true
    )

    @markdown_renderer.render(string).html_safe
  end

  # Returns a html link to a linkedin URL or profile id.
  def linkedin_link(url)
    text = url # link text
    # User id provided, generate correct URL
    if url =~ /\A[a-z0-9\-]+\Z/i
      url = "http://www.linkedin.com/in/#{text}"
    # URL provided, determine user id
    elsif url =~ %r{linkedin\.com/(?:pub|in)/([^/?#\s]+)}
      text = $1
    else
      text = "linkedin.com"
    end
    content_tag :a, text, href: url, class: 'linkedin', rel: 'external'
  end
end
