class CustomersController < ApplicationController
  before_action :authorize
  
  def index
    
  end
  
  def new
    @customer = Customer.new
  end
  
end
