require 'capistrano_colors'

set :application, 'studs'

# Source repository
set :repository, 'git@mogel.nu:studs.git'
set :scm, :git

# Specify branch to deploy with:
# cap deploy -s branch={name}
set :branch, fetch(:branch, 'master')

# Stages
set :stages, %w(production)
set :default_stage, 'production'
require 'capistrano/ext/multistage'

# Deploy target
set :deploy_to, "/var/rails/#{application}"
set :tmp_path, '/var/tmp/rails'

# System
set :user, 'rails'
set :use_sudo, false
set :ssh_options, { :forward_agent => true }

# Number of versions to keep
set :keep_releases, 10
after 'deploy:update_code', 'deploy:cleanup'

# Roles
clusterfluff_domain = 'clusterfluff.ben-and-jerrys.stacken.kth.se'
role :app, clusterfluff_domain, :alias => 'clusterfluff'
role :web, clusterfluff_domain, :alias => 'clusterfluff'
role :db,  clusterfluff_domain, :alias => 'clusterfluff', :primary => true

set :rails_env, 'production'
default_environment['RAILS_ENV'] = 'production'
#default_run_options[:shell] = 'bash'

# Bundler
set :bundle_cmd, '/usr/local/bin/1.9.2_bundle'
require 'bundler/capistrano'

# Additional shared paths
set :shared_children, shared_children + %w(public/uploads)
set :shared_files, %w(config/database.yml config/email.yml config/unicorn.rb)
set(:shared_file_path) { shared_path }
require 'capistrano/shared_file'
  
namespace :deploy do
  desc "Deploy"
  task :default do
    update
    restart
    clear_cache
  end

  desc "Restart server (kill the unicorns)"
  task :restart, :except => { :no_release => true } do
    pid = "#{shared_path}/pids/unicorn.pid"
    run "test -e #{pid} && kill -HUP `cat #{pid}` || /bin/true"
    pid = "#{shared_path}/pids/unicorn.6050.pid"
    run "test -e #{pid} && kill -HUP `cat #{pid}` || /bin/true"
  end

  desc "Run database migrations"
  task :migrate, :except => {:no_release => true} do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} #{bundle_cmd} exec rake db:migrate"
  end

  desc "Update code and deploy with migrations applied"
  task :migrations do
    transaction do
      update_code
    end
    migrate
    restart
  end

  desc "Clear cached objects"
  task :clear_cache do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} #{bundle_cmd} exec rake resumes:clean"
  end

  desc "Seed the database"
  task :seed do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} #{bundle_cmd} exec rake db:seed"
  end
end

# Shorten remote output prefixes
class Capistrano::ServerDefinition
  def to_s
    @to_s ||= begin
      s = @options[:alias] || host
      s = "#{user}@#{s}" if user
      s = "#{s}:#{port}" if port && port != 22
      s
    end
  end
end
