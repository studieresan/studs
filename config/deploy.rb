set :application, 'studs'
set :repository, 'https://mogelbro@github.com/mogelbrod/studs'
set :scm, :git

set :branch, fetch(:branch, 'master')

set :stages, ['staging', 'production']
set :default_stage, 'staging'
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

# Additional shared paths
set :shared_children, shared_children + %w(public/uploads)
set :shared_files, %w(config/database.yml)
set(:shared_file_path) { shared_path }
require 'capistrano/shared_file'

set :default_environment, {
	'PATH' => "#{deploy_to}/bin:$PATH",
	'GEM_HOME' => "#{deploy_to}/gems"
}

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

namespace :deploy do
	desc "Deploy"
	task :default do
		update
		restart
		clear_cache
	end
	
	desc "Restart nginx"
	task :restart do
		run "/home/studs/webapps/rails/bin/restart"
	end

	desc "Run database migrations"
	task :migrate, :except => {:no_release => true} do
		run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake db:migrate"
	end

	desc "Reset database"
	task :reset do
		run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake db:reset"
	end

	desc "Clear cached objects"
	task :clear_cache do
		run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake resumes:clean"
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