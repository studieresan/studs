class ApplicationController < ActionController::Base
  helper MenuHelper

  protect_from_forgery
end
