set :deploy_to, "/home/studs/webapps/rails_staging"
set :shared_path, "#{deploy_to}/shared"
set :branch, 'staging'
set :default_environment, {
	'PATH' => "#{deploy_to}/bin:$PATH",
	'GEM_HOME' => "#{deploy_to}/gems"
}