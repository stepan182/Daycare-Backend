class CustomersController < ApplicationController
  before_action :authorize
  protect_from_forgery :except => [:get_customer_list]
  
  def index
    
  end

  def create_customer
  end

  def edit_customer
  end

  def get_customer_list
    
    if params["country"].present? && !params["customer_type_id"].present?
      customers = Customer.where(country: params["country"])
    
    elsif params["country"].present? && params["customer_type_id"].present?
      customers = Customer.where(country: params["country"], customer_type_id: params["customer_type_id"])
    end
    
    respond_to do |format|
      format.json do
        render json: customers
      end
    end
  end
  
  def new
    @customer = Customer.new
    @customer_type = CustomerType.new
    @type_providers = CustomerType.all
    @user_type = UserType.new
    @daycare_department = DaycareDepartment.new
  end
  
  def edit
    @customer = Customer.find(params[:id])
    @user_type = UserType.new
    @user_type_providers = UserType.all
    @daycare_department = DaycareDepartment.new
    #@customer_dept = @customer.daycare_departments
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(customer_params)
      flash[:success] = "Customer updated"
      redirect_to '/customers'
    else
      render 'edit'
    end
  end

  def create
    @customer = Customer.new(customer_params)
    
    if @customer.save
      flash[:success] = "Success: customer has been added"
      redirect_to '/customers'
    else
      @customer_type = CustomerType.new
      @type_providers = CustomerType.all
      @user_type = UserType.new
      @daycare_department = DaycareDepartment.new
      @departments_providers = DaycareDepartment.all
      
      render 'new'
    end
  end
  
  def import_new
    @customer = Customer.new
  end
  
  def import
    Customer.import(params[:file])
    flash[:success] = "Success: customers were loaded"
    redirect_to '/customers'
  end

  def edit_all
    @type_providers = CustomerType.all
  end

  def destroy
    @customer = Customer.find(params["id"])
    @customer.destroy
    flash[:success] = "Customer deleted"
    redirect_to '/customers'
  end
  
  private

    def customer_params
      params.require(:customer).permit(:customer_name, :username, :password, :email, :country, 
      :customer_type_id, :user_type_id, :daycare_department_ids => [])
    end
  
end
