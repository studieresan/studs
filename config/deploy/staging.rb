set :deploy_to, "/home/studs/webapps/rails_staging/#{stage}"
set :shared_path, "#{deploy_to}/shared"
set :branch, 'staging'