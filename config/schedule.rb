# Use this file to easily define all of your cron jobs.
# Learn more: http://github.com/javan/whenever

env :PATH, ENV['PATH']
set :output, 'log/whenever.log'

# Location of bundle binary depends on environment
bundle_cmd = if @environment == 'development'
  '/usr/local/bin/bundle'
else
  '/usr/local/bin/1.9.2_bundle'
end

job_type :rake, "cd :path && RAILS_ENV=:environment #{bundle_cmd} exec rake :task --silent :output"

every 1.minutes do
  command 'echo $USER'
  rake 'feeds'
end
