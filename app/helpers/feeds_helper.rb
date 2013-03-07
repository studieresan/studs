module FeedsHelper
  def tweet_to_html(string)
    msg = String.new(string)

    # Linkify author
    msg.sub!(/\A(\w{1,15}):/) do
      link_to($1, "http://twitter.com/#{$1}", { :class => "author" }) + ":"
    end

    # Linkify mentions
    msg.gsub!(/@(\w{1,15})/) do
      link_to($&, "http://twitter.com/#{$1}")
    end

    # Linkify hashtags
    msg.gsub!(/#(\w+)/) do
      link_to($&, "http://twitter.com/search?q=%23#{$1}")
    end

    # Linkify URLs
    string.scan(/https?\:\/\/([a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}[\/a-zA-Z0-9\-\.]*)/) do
      msg.sub!($0, link_to($1, $0))
    end
    
    return msg
  end
end
