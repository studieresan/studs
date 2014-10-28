module FormattingHelper
  # Returns a string split into HTML paragraph tags.
  def paragraphize(string)
    # Trim whitespace
    string = string.gsub(/\A\s+|\s+\Z/, '').gsub(/\r\n?/, "\n")
    ('<p>' + string.split(/\n{2,}/).join('</p><p>') + '</p>').html_safe
  end

  def markdown(string)
    options = {
        hard_wrap: true,
        safe_links_only: true,
        no_images: false,
        filter_html: false
    }
    extensions = {
        tables: true,
        fenced_code_blocks: false,
        autolink: true,
        strikethrough: true,
        superscript: true
    }
    renderer = StudsRenderer.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(string).html_safe
  end

  def teaser(string)
    string = string[0, 300]
    # Trim the string from the last non-word character(s) to avoid cut off words
    string = string[0...string.rindex(/\W+/)]
    string + '...'
  end
end

class StudsRenderer < Redcarpet::Render::HTML
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper
  include ActionView::Helpers::UrlHelper

  def parse_media_link(link)
    puts link
    matches = link.match(/^\/uploads\/post_image\/([\w\d\.\/]+)(?:\|(\w+))?$/)

    unless matches.nil?
      if ["left", "right", "square", "textright", "textleft"].include?(matches[2])
        size = "square"
      elsif matches[2] == "full"
        size = "full"
      else
        size = "original"
      end
    end

    {
        :id => matches[1],
        :size => size,
        :class => matches[2]

    } if matches
  end

  def image(link, title, alt_text)
    size = nil
    klass = nil

    if nil != (parse = parse_media_link(link))
      media = PostImage.find_by_image(parse[:id])
      if media
        size = media.image.size
        if parse[:size] == "original"
          link = media.image.url()
        else
          link = media.image.url(parse[:size])
        end

        klass = parse[:class]
      end
    end

    image_tag(link, :size => size, :title => title, :alt => alt_text, :class => klass)
  end


end