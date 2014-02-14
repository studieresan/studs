require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module Studs
  class Application < Rails::Application
    config.encoding = 'utf-8'
    config.time_zone = 'Stockholm'
    config.i18n.default_locale = :sv

    config.filter_parameters += [:password, :password_confirmation]
    config.active_record.whitelist_attributes = false

    config.autoload_paths << "#{config.root}/app/libs"

    config.assets.initialize_on_precompile = false
    config.assets.enabled = true
    config.assets.version = '1.0'
    config.assets.precompile += %w(application.js application.css global.js)

    config.generators do |g|
      g.template_engine :haml
      g.helper          false
      g.test_framework  :mini_test, spec: false, fixture: false
      g.view_specs      false
      g.helper_specs    false
      g.assets          false
      g.stylesheets     false
    end
  end
end
