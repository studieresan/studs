source 'https://rubygems.org'

gem 'rails', '3.2.3'

gem 'acts-as-taggable-on'

gem 'bcrypt-ruby'
gem 'sorcery'
gem 'cancan'

gem 'responders'

gem 'haml-rails'

group :development do
  gem 'sqlite3'

  gem 'capistrano', :require => nil
  gem 'capistrano-shared_file', :require => nil
  gem 'capistrano_colors', :require => nil
end

group :test do
  gem 'minitest-rails'
  gem 'minitest-rails-shoulda', '~> 0.3.0'
  gem 'minitest-rails-capybara'

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
