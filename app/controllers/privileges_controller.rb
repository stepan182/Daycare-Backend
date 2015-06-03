class PrivilegesController < ApplicationController
  before_action :authorize
  protect_from_forgery :except => [:get_customers_by_country]
  
  def index
  end
  
  def get_customers_by_country
    
    if params["country"].present? && !params["customer_type_id"].present? && !params["daycare_user_type"].present? && !params["daycare_department_ids"].present?
      customers = Customer.where(country: params["country"])
    
    elsif params["country"].present? && params["customer_type_id"].present? && !params["daycare_user_type"].present? && !params["daycare_department_ids"].present?
      customers = Customer.where(country: params["country"], customer_type_id: params["customer_type_id"])
    
    elsif params["country"].present? && !params["customer_type_id"].present? && params["daycare_user_type"].present? && !params["daycare_department_ids"].present?
      customers = Customer.where(country: params["country"], daycare_user_type: params["daycare_user_type"])
    
    elsif params["country"].present? && params["customer_type_id"].present? && params["daycare_user_type"].present? && !params["daycare_department_ids"].present?
      customers = Customer.where(country: params["country"], customer_type_id: params["customer_type_id"], daycare_user_type: params["daycare_user_type"])
    
    elsif params["country"].present? && !params["customer_type_id"].present? && !params["daycare_user_type"].present? && params["daycare_department_ids"].present?
      customers = Customer.where(country: params["country"]).joins(:daycare_departments).where('daycare_departments.id IN (?) ', params["daycare_department_ids"])
    
    elsif params["country"].present? && params["customer_type_id"].present? && !params["daycare_user_type"].present? && params["daycare_department_ids"].present?
      customers = Customer.where(country: params["country"], customer_type_id: params["customer_type_id"]).joins(:daycare_departments).where('daycare_departments.id IN (?) ', params["daycare_department_ids"])
      
    elsif params["country"].present? && !params["customer_type_id"].present? && params["daycare_user_type"].present? && params["daycare_department_ids"].present?
      customers = Customer.where(country: params["country"], daycare_user_type: params["daycare_user_type"]).joins(:daycare_departments).where('daycare_departments.id IN (?) ', params["daycare_department_ids"])
      
    elsif params["country"].present? && params["customer_type_id"].present? && params["daycare_user_type"].present? && params["daycare_department_ids"].present?
      customers = Customer.where(country: params["country"], customer_type_id: params["customer_type_id"], daycare_user_type: params["daycare_user_type"]).joins(:daycare_departments).where('daycare_departments.id IN (?) ', params["daycare_department_ids"])
    end
    
    respond_to do |format|
      format.json do
        render json: customers, :only => [:id, :customer_name]
      end
    end
  end
  
  def create
    @selected_customers = params["customer_id"]
    
    # if no customers selected
    if @selected_customers.blank?
      flash[:danger] = "Atleast one customer has to be selected"
      redirect_to :action => :index
    else
      # get permissions
      @permissions = Array.new
      @selected_customers.each do |c|
        tmp_cust = Customer.where(id: c).first
        if !tmp_cust.nil?
          tmp_privs = tmp_cust.privileges.pluck
          unless @permissions.include?(tmp_privs)
            @permissions << tmp_privs
          end
        end
        
    end
    end
    
    @privilege = Privilege.new
  end
  
  def create_update
    customer = params[:customer_ids].split(",")
    customer.each do |c|
      tmp_cust = Customer.find(c)
      if !tmp_cust.nil?
        tmp_cust.update_attribute(:privilege_ids, params[:privilege_ids])
      end
    end
    
    flash[:success] = "Success: Privileges updated"
    redirect_to '/home'
    
  end
  
end
