source 'https://rubygems.org'

gem 'rails', '3.2.11'

gem 'airbrake'

# Authentication and authorization
gem 'bcrypt-ruby'
gem 'sorcery'
gem 'cancan'

gem 'acts-as-taggable-on'
gem 'auto_strip_attributes'

gem 'responders'

# Markup and string tools
gem 'haml-rails'
gem 'stringex'
gem 'redcarpet'

# File uploads
gem 'mini_magick'
gem 'carrierwave'

# RSS feed parsing
gem 'feedzirra'

# Cron jobs
gem 'whenever', :require => false

# Mail form
gem 'mail_form'

group :development do
  gem 'sqlite3'

  gem 'capistrano', :require => nil
  gem 'capistrano-shared_file', :require => nil
  gem 'capistrano_colors', :require => nil
end

group :production do
  gem 'mysql2'
  gem 'unicorn'
  gem 'yui-compressor'
end

group :assets do
  # Improves assets:precompile by only compiling what's needed.
  # Can potentially cause problems with asset rollback and invalidation.
  gem 'turbo-sprockets-rails3'
end
