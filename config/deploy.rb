set :application, 'studs'
set :repository, 'https://mogelbro@github.com/mogelbrod/studs'
set :scm, :git

set :branch, fetch(:branch, 'webfaction-deploy')

set :stages, %w(production)
set :default_stage, 'production'
require 'capistrano/ext/multistage'


webfactional_domain = 'studs.webfactional.com'
role :app, webfactional_domain, :alias => 'webfactional'
role :web, webfactional_domain, :alias => 'webfactional'
role :db,  webfactional_domain, :alias => 'webfactional', :primary => true

set :user, "studs"
set :scm_username, "mbark"
set :use_sudo, false
default_run_options[:pty] = true

set :rails_env, 'production'
default_environment['RAILS_ENV'] = 'production'

set :deploy_to, "/home/studs/webapps/rails"

set :bundle_cmd, "/home/studs/webapps/rails/bin/bundle"
require 'bundler/capistrano'

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

set :default_environment, {
  'PATH' => "#{deploy_to}/bin:$PATH",
  'GEM_HOME' => "#{deploy_to}/gems" 
}

namespace :deploy do
	desc "Restart nginx"
	task :restart do
		run "/home/studs/webapps/rails/bin/restart"
	end
end

# vi borde kanske köra något med rake db:migrate
# någonting med att byta namn på database.yml.dist -> database.yml

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end