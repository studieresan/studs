set :deploy_to, "/home/studs/webapps/rails"
set :shared_path, "#{deploy_to}/shared"
set :branch, 'master'
set :default_environment, {
	'PATH' => "#{deploy_to}/bin:$PATH",
	'GEM_HOME' => "#{deploy_to}/gems"
}