module FeedHelper
  def tweet_to_html(string)
    msg = String.new(string)

    # Linkify author
    msg.sub!(/\A(\w{1,15}):/) do
      link_to($1, "http://twitter.com/#{$1}", { class: 'author', rel: 'nofollow' }) + ":"
    end

    # Linkify mentions
    msg.gsub!(/@(\w{1,15})/) do
      link_to($&, "http://twitter.com/#{$1}", rel: 'nofollow')
    end

    # Linkify hashtags
    msg.gsub!(/#(\w+)/) do
      link_to($&, "http://twitter.com/search?q=%23#{$1}", rel: 'nofollow')
    end

    # Linkify URLs
    string.scan(/https?\:\/\/([a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}[\/a-zA-Z0-9\-\.]*)/) do
      msg.sub!($&, link_to($1, $&, rel: 'nofollow'))
    end
    
    return msg
  end

  def instagram_to_html(entry)
    img_tag = image_tag(entry.url, alt: entry.title, title: entry.title)
    link = link_to(img_tag, entry.url, class: 'instagram', data: {lightbox: 'instagram'}, title: entry.title, rel: 'nofollow')

    return link;
  end
end
