source 'https://rubygems.org'

gem 'rails', '3.2.3'

gem 'sqlite3'
gem 'mysql2'

gem 'acts-as-taggable-on'

gem 'bcrypt-ruby'
gem 'sorcery'
gem 'cancan'

gem 'responders'

gem 'haml-rails'

group :development do
  gem 'capistrano', :require => nil
  gem 'capistrano-shared_file', :require => nil
  gem 'capistrano_colors', :require => nil
end

group :production do
  gem 'unicorn'
  gem 'yui-compressor'
end

group :assets do
  # Improves assets:precompile by only compiling what's needed.
  # Can potentially cause problems with asset rollback and invalidation.
  gem 'turbo-sprockets-rails3'
end
