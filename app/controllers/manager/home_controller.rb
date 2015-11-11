class Manager::HomeController < ApplicationController
  before_action :manager_authorize
  layout "manager"
  
  def index
  end
  
  
  
end