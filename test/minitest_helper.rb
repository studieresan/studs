ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)

require "minitest/autorun"
require "minitest/rails"
require "minitest/rails/shoulda"
require "minitest/rails/capybara"

require 'factory_girl'
FactoryGirl.find_definitions

class MiniTest::Rails::ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
end

class MiniTest::Rails::ActionController::TestCase
  before do
    klass = self.class.name.match(/((.*)Controller)/)[1].constantize

    @controller = klass.new
    @controller.instance_eval do
      @_request    = ActionController::TestRequest.new
      @_response   = ActionController::TestResponse.new
      @_routes     = Rails.application.routes

      @_request.env['PATH_INFO'] = nil
    end
  end

  def subject
    @controller
  end
end
