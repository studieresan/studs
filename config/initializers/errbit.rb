Airbrake.configure do |config|
  config.api_key = 'b89288c0c393635f415b015c499c2d54'
  config.host    = 'errbit.datasektionen.se'
  config.port    = 80
  config.secure  = config.port == 443
end