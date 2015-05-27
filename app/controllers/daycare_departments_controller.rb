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
  
end
