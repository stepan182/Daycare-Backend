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
    
    if params["country"].present? && !params["customer_type_id"].present? && !params["partner_id"].present? && !params["franchise_id"].present?
      customers = Customer.where(country: params["country"])
    
    elsif params["country"].present? && params["customer_type_id"].present? && !params["partner_id"].present? && !params["franchise_id"].present?
      customers = Customer.where(country: params["country"], customer_type_id: params["customer_type_id"])

    elsif params["country"].present? && params["customer_type_id"].present? && params["partner_id"].present? && !params["franchise_id"].present?
      customers = Customer.where(country: params["country"], customer_type_id: params["customer_type_id"], partner_id: params["partner_id"])

    elsif params["country"].present? && params["customer_type_id"].present? && !params["partner_id"].present? && params["franchise_id"].present?
      customers = Customer.where(country: params["country"], customer_type_id: params["customer_type_id"], franchise_id: params["franchise_id"])
    end
    
    respond_to do |format|
      format.json do
        render json: customers
      end
    end
  end
  
  def new
    @next_id = Customer.maximum(:id).to_i.next
    @customer = Customer.new
    @type_providers = CustomerType.all
    @franchises = Franchise.all
    @partners = Partner.all
  end

  def create
    @customer = Customer.new(customer_params)
    
    if @customer.save
      flash[:success] = "Success: customer has been added"
      redirect_to '/customers'
    else
      #@customer = Customer.new
      @type_providers = CustomerType.all
      @franchises = Franchise.all
      @partners = Partner.all
      
      render 'new'
    end
  end
  
  def edit
    @customer = Customer.find(params[:id])
    @franchises = Franchise.all
    @partners = Partner.all
    @customer_dept = @customer.daycare_departments
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(customer_params)
      flash[:success] = "Customer updated"
      redirect_to '/customers'
    else
      #@customer = Customer.find(params[:id])
      @franchises = Franchise.all
      @partners = Partner.all
      @customer_dept = @customer.daycare_departments
      render 'edit'
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
    @franchises = Franchise.all
    @partners = Partner.all
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
      :customer_type_id, :user_type_id, :franchise_id, :partner_id, :address, :daycare_department_ids => [])
    end
  
end
