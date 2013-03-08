require 'feedzirra'

TWITTER_QUERY = "studieresan"
TWITTER_RSS_FEED = "http://search.twitter.com/search.rss?q=%s&include_entities=false&show_user=true&result_type=recent"
TUMBLR_RSS_FEED = "http://studs13.tumblr.com/rss"

def fetch_and_save_feed_items(provider, feed_url)
  puts "Fetching #{provider} feed"
  puts feed_url
  feed = Feedzirra::Feed.fetch_and_parse(feed_url)
  
  if feed.nil?
    puts "No results, aborting"
    return
  end

  puts "Got #{feed.entries.size} entries"
  puts "=" * 60
  feed.entries.each do |entry|
    create_external_post(provider, entry)
  end
  puts "=" * 60
end

def create_external_post(provider, entry)
  attrs = {
    provider: provider.to_s,
    guid: entry.id,
    url: entry.url,
    title: entry.title.gsub(/ *\n */, ' '),
    pubdate: (entry.published || Time.now)
  }

  if ExternalPost.create(attrs)
    puts "> #{entry.title}"
  else
    puts "! Failed to save #{entry.id}; #{entry.title}"
  end
end

namespace :feeds do
  task twitter: :environment do
    url = TWITTER_RSS_FEED.sub('%s', Rack::Utils.escape(TWITTER_QUERY))
    fetch_and_save_feed_items(:twitter, url)
  end

  task tumblr: :environment do
    fetch_and_save_feed_items(:tumblr, TUMBLR_RSS_FEED)
  end
end

task feeds: ['feeds:twitter', 'feeds:tumblr']
