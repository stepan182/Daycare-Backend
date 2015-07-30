module Api
  class ApiController < ApplicationController
    skip_before_filter :verify_authenticity_token
    protect_from_forgery with: :null_session
    before_filter :authenticate
    
    def current_user
      @current_user
    end

    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        if username == API_USERNAME && password == API_PASSWORD 
          true
        else
          false
        end
      end
    end
  end
end