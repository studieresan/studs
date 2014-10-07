set :deploy_to, "/home/studs/webapps/studs2014"
set :shared_path, "#{deploy_to}/shared"
set :branch, 'studs2014'
set :default_environment, {
	'PATH' => "#{deploy_to}/bin:$PATH",
	'GEM_HOME' => "#{deploy_to}/gems"
}