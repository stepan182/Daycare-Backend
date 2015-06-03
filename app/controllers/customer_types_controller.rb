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
  
  def index
    @customer_types = CustomerType.all
    @customer_type = CustomerType.new
  end
  
  def destroy
    @customer_type = CustomerType.find(params["id"])
    @customer_type.destroy
    flash[:success] = "Customer type deleted"
    redirect_to request.referrer
  end
  
  
  def update
    @customer_type = CustomerType.find(params[:id])
        
      if @customer_type.update_attributes(customer_type_params)
        flash[:success] = "Customer type updated"
        redirect_to request.referrer
      else
        flash[:danger] = "Customer type not updated. " + @customer_type.errors.full_messages.to_s
        redirect_to request.referrer
      end
      
  end
  
  private

    def customer_type_params
      params.require(:customer_type).permit(:type_name)
    end
  
end
