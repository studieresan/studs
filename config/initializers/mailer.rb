filename = File.join(File.dirname(__FILE__), '..', 'email.yml')
if File.file?(filename)
  config = YAML::load_file(filename)
 
  if config.is_a?(Hash) && config.has_key?(Rails.env)
    # Enable deliveries
    ActionMailer::Base.perform_deliveries = true
 
    config[Rails.env].each do |k, v|
      v.symbolize_keys! if v.respond_to?(:symbolize_keys!)
      ActionMailer::Base.send("#{k}=", v)
    end
  end
end
