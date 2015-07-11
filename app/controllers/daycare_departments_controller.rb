class DaycareDepartmentsController < ApplicationController
  before_action :authorize
  protect_from_forgery :except => [:update, :delete, :create, :update, :get_departments]
  respond_to :html, :js, :json
  
  def new
    @daycare_department = DaycareDepartment.new
  end
  
  def create
    
    @daycare_department = DaycareDepartment.new(department_name: params[:department_name], franchise_id: params["franchise_id"])
    
    if @daycare_department.save
      respond_with @daycare_department
    else
      respond_with @daycare_department.errors, :status => :unprocessable_entity
    end 
  end
  
  def index
    if params["franchise_id"].present?
      @daycare_departments = DaycareDepartment.where(franchise_id: params[:franchise_id])
    end

    if params["customer_id"].present? && !params["franchise_id"].present?
      @daycare_departments = Customer.find(params["customer_id"]).daycare_departments
    end

    @daycare_department = DaycareDepartment.new
  end
  
  def destroy
    @daycare_department = DaycareDepartment.find(params["id"])
    if @daycare_department.destroy
      render :json => {:status => "ok"}
    end
  end
  
  
  def update
    @daycare_department = DaycareDepartment.find(params[:id])
        
      if @daycare_department.update_attributes(department_params)
        render :json => {id: @daycare_department.id, department_name: @daycare_department.department_name}
      else
        respond_with @daycare_department.errors, :status => :unprocessable_entity
      end 
      
  end

  def get_departments
    
    if params["franchise_id"].present?
      departments = DaycareDepartment.where(franchise_id: params["franchise_id"])
    elsif params["customer_id"].present? && !params["franchise_id"].present?
      departments = Customer.find(params["customer_id"]).daycare_departments
    elsif params["customer_type"].present? && !params["customer_id"].present? && !params["franchise_id"].present?
      departments = Customer.find_by(customer_type_id: params["customer_type"]).daycare_departments
    end
    
    respond_to do |format|
      format.json do
        render json: departments
      end
    end
  end
  
  private

    def department_params
      params.permit(:department_name)
    end
  
end
