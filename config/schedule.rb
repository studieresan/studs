# Use this file to easily define all of your cron jobs.
# Learn more: http://github.com/javan/whenever

env :PATH, ENV['PATH']
set :output, 'log/whenever.log'

home_path = "$HOME/webapps/rails/current"
gem_home = "GEM_HOME=$HOME/webapps/rails/gems"
rubylib = "RUBYLIB=$HOME/webapps/rails/lib"
path = "PATH=$HOME/webapps/rails/bin:/usr/local/bin/:$PATH"

job_type :rake, "cd #{home_path} && #{gem_home} #{rubylib} #{path} RAILS_ENV=:environment bundle exec rake :task --silent :output"

every 5.minutes do
  rake 'feeds'
end
