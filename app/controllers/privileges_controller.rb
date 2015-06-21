class PrivilegesController < ApplicationController
  before_action :authorize
  protect_from_forgery :except => [:get_customers_by_country]
  
  def index
    @type_providers = CustomerType.all
    @franchises = Franchise.all
    @partners = Partner.all
  end
  
  def get_customers_by_country
    
    if params["country"].present? && !params["customer_type_id"].present? && !params["user_type_id"].present? && !params["partner_id"].present? && !params["franchise_id"].present?
      customers = Customer.where(country: params["country"])
    
    elsif params["country"].present? && params["customer_type_id"].present? && !params["user_type_id"].present? && !params["partner_id"].present? && !params["franchise_id"].present?
      customers = Customer.where(country: params["country"], customer_type_id: params["customer_type_id"])
    
    elsif params["country"].present? && params["customer_type_id"].present? && params["user_type_id"].present? && !params["partner_id"].present? && !params["franchise_id"].present?
      customers = Customer.where(country: params["country"], user_type_id: params["user_type_id"])
    
    elsif params["country"].present? && params["customer_type_id"].present? && !params["user_type_id"].present? && params["partner_id"].present? && !params["franchise_id"].present?
      customers = Customer.where(country: params["country"], partner_id: params["partner_id"])
    
    elsif params["country"].present? && params["customer_type_id"].present? && params["user_type_id"].present? && params["partner_id"].present? && !params["franchise_id"].present?
      customers = Customer.where(country: params["country"], user_type_id: params["user_type_id"], partner_id: params["partner_id"])
    
    elsif params["country"].present? && params["customer_type_id"].present? && !params["user_type_id"].present? && !params["partner_id"].present? && params["franchise_id"].present?
      customers = Customer.where(country: params["country"], franchise_id: params["franchise_id"])
    
    elsif params["country"].present? && params["customer_type_id"].present? && params["user_type_id"].present? && !params["partner_id"].present? && params["franchise_id"].present?
      customers = Customer.where(country: params["country"], user_type_id: params["user_type_id"], franchise_id: params["franchise_id"])
      
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
    
    customer.each do |cust|

        params["privilege_ids"].each do |priv|
          if !params["existing_permissions"].to_s.include?(priv)
            @privilege = Privilege.create(privilege_name: priv, user_type_id: params["user_type_id"])
            @privilege.save

            @privilege.update_attribute(:customer_ids, cust)
          end
        end
    end

    flash[:success] = "Success: Privileges updated"
    redirect_to '/home'
    
  end
  
end
