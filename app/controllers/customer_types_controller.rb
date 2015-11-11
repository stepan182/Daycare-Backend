class CustomerTypesController < ApplicationController
  before_action :authorize
  protect_from_forgery :except => [:update, :delete, :create, :update]
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
    if @customer_type.destroy
      render :json => {:status => "ok"}
    end
  end


  def update
    @customer_type = CustomerType.find(params[:id])

    if @customer_type.update_attributes(customer_type_params)
      render :json => {id: @customer_type.id, type_name: @customer_type.type_name}
    else
      respond_with @customer_type.errors, :status => :unprocessable_entity
    end

  end

  private

  def customer_type_params
    params.permit(:type_name)
  end

end
