set :application, 'studs'
set :repository, 'https://mogelbro@github.com/mogelbrod/studs'
set :scm, :git

set :branch, fetch(:branch, 'master')

webfactional_domain = 'studs.webfactional.com'
role :app, webfactional_domain, :alias => 'webfactional'
role :web, webfactional_domain, :alias => 'webfactional'
role :db,  webfactional_domain, :alias => 'webfactional', :primary => true

set :user, "studs"
set :scm_username, "mbark"
set :use_sudo, false
default_run_options[:pty] = true

set :deploy_to, "/home/studs/webapps/rails"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
	desc "Restart nginx"
	task :restart do
		run "#{deploy_to}/bin/restart"
	end

	namespace :assets do
		task :precompile, :roles => :web, :except => { :no_release => true } do
			from = source.next_revision(current_revision)
			if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
				run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
			else
				logger.info "Skipping asset pre-compilation because there were no asset changes"
			end
		end
	end
end


# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end