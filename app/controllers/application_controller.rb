class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include LoginHelper
  #Remove layouts for all ajax calls
  layout proc { |c| c.request.xhr? ? false : "application" }
end
