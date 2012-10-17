require 'capistrano_colors'

set :application, 'studs'

# Source repository
set :repository, 'git@mogel.nu:studs.git'
set :scm, :git
set :branch, :master

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
  end

  desc "Restart server (kill the unicorns)"
  task :restart, :except => { :no_release => true } do
    pid = "#{shared_path}/pids/unicorn.pid"
    run "test -e #{pid} && kill -USR2 `cat #{pid}` || /bin/true"
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
end

=begin

set(:latest_release)  { fetch(:current_path) }
set(:release_path)    { fetch(:current_path) }
set(:current_release) { fetch(:current_path) }

rev_cmd = "cd #{current_path}; git rev-parse --short"
set(:current_revision)  { capture("#{rev_cmd} HEAD").strip }
set(:latest_revision)   { capture("#{rev_cmd} HEAD").strip }
set(:previous_revision) { capture("#{rev_cmd} HEAD@{1}").strip }

namespace :deploy do

  desc "Update the deployed code."
  task :update_code, :except => { :no_release => true } do
    run "cd #{current_path}; git pull; git reset --hard #{branch}"
    finalize_update
  end
  
  desc "Update the database (overwritten to avoid symlink)"
  task :migrations do
    transaction do
      update_code
    end
    migrate
    restart
  end

  namespace :rollback do
    desc "Moves the repo back to the previous version of HEAD"
    task :repo, :except => { :no_release => true } do
      set :branch, "HEAD@{1}"
      deploy.default
    end
    
    desc "Rewrite reflog so HEAD@{1} will continue to point to at the next previous release."
    task :cleanup, :except => { :no_release => true } do
      run "cd #{current_path}; git reflog delete --rewrite HEAD@{1}; git reflog delete --rewrite HEAD@{1}"
    end
    
    desc "Rolls back to the previously deployed version."
    task :default do
      rollback.repo
      rollback.cleanup
    end
  end
end

=end

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
