require 'feedzirra'

TWITTER_QUERY = "#studs2016"
TWITTER_RSS_FEED = "http://search.twitter.com/search.rss?q=%s&include_entities=false&show_user=true&result_type=recent"
TUMBLR_RSS_FEED = "http://studs13.tumblr.com/rss"
INSTAGRAM_HASHTAGS = ["studs2016", "studs16"]
INSTAGRAM_RSS_FEED = "http://instagr.am/tags/%s/feed/recent.rss"

def puts_with_time(string)
  puts "#{Time.now.strftime('%Y-%m-%d %H:%M:%S')} -- #{string}"
end

def fetch_and_save_feed_items(provider, feed_url)
  puts_with_time "Fetching #{provider} feed"
  #puts feed_url
  feed = Feedzirra::Feed.fetch_and_parse(feed_url)
  
  if feed.nil? || !feed.respond_to?(:entries) || feed.entries.blank?
    puts_with_time "No results from feed"
    return
  end

  puts_with_time "Got #{feed.entries.size} entries from feed"
  new_count = 0

  feed.entries.each do |entry|
    ret = create_external_post(provider, entry)
    if ret
      new_count += 1
      puts " + #{ret}"
    end
  end

  puts_with_time "#{new_count} new #{provider} entries saved"
end

def create_external_post(provider, entry)
  ep = ExternalPost.new({
    provider: provider.to_s,
    guid: entry.id,
    url: entry.url,
    title: entry.title.gsub(/ *\n */, ' '),
    pubdate: (entry.published || Time.now)
  })

  return ep.save ? ep.guid : false
end

namespace :feeds do
  task twitter: :environment do
    url = TWITTER_RSS_FEED.sub('%s', Rack::Utils.escape(TWITTER_QUERY))
    fetch_and_save_feed_items(:twitter, url)
  end

  task tumblr: :environment do
    fetch_and_save_feed_items(:tumblr, TUMBLR_RSS_FEED)
  end

  task instagram: :environment do
    INSTAGRAM_HASHTAGS.each do |hashtag|
      url = INSTAGRAM_RSS_FEED.sub('%s', Rack::Utils.escape(hashtag))
      fetch_and_save_feed_items(:instagram, url)
    end
  end
end

#task feeds: ['feeds:twitter', 'feeds:tumblr', 'feeds:instagram']
task feeds: ['feeds:instagram']