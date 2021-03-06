source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Authentication and authorization
gem 'bcrypt-ruby'
gem 'sorcery'
gem 'cancan'

gem 'acts-as-taggable-on'
gem 'auto_strip_attributes'

gem 'responders'

gem 'rubyzip', '>= 1.0.0' # will load new rubyzip version
gem 'zip-zip' # will load compatibility for old rubyzip API.

# Markup and string tools
gem 'haml-rails'
gem 'stringex'
gem 'redcarpet'

# File uploads
gem 'mini_magick'
gem 'carrierwave'

# RSS feed parsing
gem 'feedzirra', git: "https://github.com/pauldix/feedzirra.git"

# Cron jobs
gem 'whenever', :require => false

# Mail form
gem 'mail_form'

group :development do
  gem 'sqlite3'

  gem 'capistrano', '< 3.0', :require => nil
  gem 'capistrano-shared_file', :require => nil
  gem 'capistrano_colors', :require => nil
end

group :production do
  gem 'therubyracer'
  gem 'mysql2'
  gem 'unicorn'
  gem 'yui-compressor'
end

group :assets do
  # Improves assets:precompile by only compiling what's needed.
  # Can potentially cause problems with asset rollback and invalidation.
  gem 'turbo-sprockets-rails3'
end
