require 'feedzirra'

TWITTER_QUERY = "lol"
TWITTER_RSS_FEED = "http://search.twitter.com/search.rss?q=%s&include_entities=false&show_user=true&result_type=recent"
TUMBLR_RSS_FEED = "http://studs13.tumblr.com/rss"

namespace :feeds do
  task twitter: :environment do
    url = TWITTER_RSS_FEED.sub('%s', Rack::Utils.escape(TWITTER_QUERY))

    puts "Fetching twitter feed: #{url}"

    feed = Feedzirra::Feed.fetch_and_parse(url)
    
    if feed.nil?
      puts "No results, aborting"
      next
    end

    feed.entries.each do |p|
      attrs = { provider: 'twitter', guid: p.id, url: p.url, title: p.title }
      if ExternalPost.create(attrs)
        puts "> #{p.title}"
      else
        puts "! Failed to save #{p.id}; #{p.title}"
      end
    end
  end

  task tumblr: :environment do
  end
end

task feeds: ['feeds:twitter', 'feeds:tumblr']
