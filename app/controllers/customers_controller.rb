class CustomersController < ApplicationController
  #require 'roo'
  before_action :authorize
  
  def index
    
  end
  
  def new
    @customer = Customer.new
    @customer_type = CustomerType.new
    @type_providers = CustomerType.all
    @daycare_department = DaycareDepartment.new
    @departments_providers = DaycareDepartment.all
  end
  
  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      flash[:success] = "Success: customer has been added"
      redirect_to '/home'
    else
      @customer_type = CustomerType.new
      @type_providers = CustomerType.all
      @daycare_department = DaycareDepartment.new
      @departments_providers = DaycareDepartment.all
      
      render 'new'
    end
  end
  
  def import_new
   
  end
  
  def import
   Customer.import(params[:file])
  end
  
  private

    def customer_params
      params.require(:customer).permit(:customer_name, :username, :password, :email, :country, 
      :customer_type_id, :daycare_user_type, :daycare_department_ids => [])
    end
  
end
