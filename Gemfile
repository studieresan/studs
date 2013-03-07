source 'https://rubygems.org'

gem 'rails', '3.2.11'

gem 'bcrypt-ruby'
gem 'sorcery'
gem 'cancan'

gem 'acts-as-taggable-on'
gem 'auto_strip_attributes'

gem 'responders'

gem 'haml-rails'
gem 'stringex'
gem 'redcarpet'

gem 'mini_magick'
gem 'carrierwave'

gem 'feedzirra'

group :development do
  gem 'sqlite3'

  gem 'capistrano', :require => nil
  gem 'capistrano-shared_file', :require => nil
  gem 'capistrano_colors', :require => nil
end

group :test do
  gem 'debugger'

  gem 'minitest-rails'
  gem 'minitest-rails-shoulda', '~> 0.3.0'
  gem 'minitest-rails-capybara'
  gem 'launchy'

  gem 'factory_girl'

  gem 'guard-bundler'
  gem 'guard-minitest'

  gem 'rb-inotify'
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
