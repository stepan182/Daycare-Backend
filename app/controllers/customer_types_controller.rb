class CustomerTypesController < ApplicationController
  before_action :authorize
  protect_from_forgery :except => [:update, :delete, :create]
  respond_to :html, :js, :json
  
  def new
    @customer_type = CustomerType.new
  end
  
  def create
    @customer_type = CustomerType.new(type_name: params[:type_name])
    if @customer_type.save
      respond_with @customer_type
    else
      respond_with @customer_type.errors, :status => :unprocessable_entity
    end 
  end
  
end
