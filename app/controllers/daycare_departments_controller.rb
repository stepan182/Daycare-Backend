class DaycareDepartmentsController < ApplicationController
  before_action :authorize
  protect_from_forgery :except => [:update, :delete, :create]
  respond_to :html, :js, :json
  
  def new
    @daycare_department = DaycareDepartment.new
  end
  
  def create
    @daycare_department = DaycareDepartment.new(department_name: params[:department_name])
    if @daycare_department.save
      respond_with @daycare_department
    else
      respond_with @daycare_department.errors, :status => :unprocessable_entity
    end 
  end
  
  def index
    @categories = DaycareDepartment.all
    @daycare_department = DaycareDepartment.new
  end
  
  def destroy
    @category = DaycareDepartment.find(params["id"])
    @category.destroy
    flash[:success] = "Department deleted"
    redirect_to request.referrer
  end
  
  
  def update
    @category = DaycareDepartment.find(params[:id])
        
      if @category.update_attributes(department_params)
        flash[:success] = "Department updated"
        redirect_to request.referrer
      else
        flash[:danger] = "Department not updated. " + @category.errors.full_messages.to_s
        redirect_to request.referrer
      end
      
  end
  
  private

    def department_params
      params.require(:daycare_department).permit(:department_name)
    end
  
end
