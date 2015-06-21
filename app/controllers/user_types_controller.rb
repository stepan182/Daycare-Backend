class UserTypesController < ApplicationController
  #before_action :authorize
  protect_from_forgery :except => [:update, :delete, :create, :update]
  respond_to :html, :js, :json
  
  def new
    @user_type = UserType.new
  end
  
  def create
    @user_type = UserType.new(user_type_name: params[:user_type_name], customer_type_id: params[:customer_type_id], franchise_id: params["franchise_id"], partner_id: params["partner_id"], customer_id: params["customer_id"])
    if @user_type.save
      respond_with @user_type
    else
      respond_with @user_type.errors, :status => :unprocessable_entity
    end 
  end
  
  def index
    if params["franchise_id"].present?
      @user_types = UserType.where(franchise_id: params[:franchise_id])
    end

    if params["partner_id"].present?
      @user_types = UserType.where(partner_id: params[:partner_id])
    end

    if params["customer_id"].present? && !params["franchise_id"].present? && !params["partner_id"].present?
      @user_types = UserType.where(customer_id: params[:customer_id])
    end

    @user_type = UserType.new
  end
  
  def destroy
    @user_type = UserType.find(params["id"])
    if @user_type.destroy
      render :json => {:status => "ok"}
    end
  end
  
  
  def update
    @user_type = UserType.find(params[:id])
        
      if @user_type.update_attributes(user_type_params)
        render :json => {id: @user_type.id, user_type_name: @user_type.user_type_name}
      else
        respond_with @user_type.errors, :status => :unprocessable_entity
      end 
      
  end

  def get_user_types
    
    if params["customer_type"].present? && !params["customer_id"].present? && !params["franchise_id"].present? && !params["partner_id"].present?
      user_types = UserType.where(customer_type: params["customer_type"])
    elsif params["customer_type"].present? && params["franchise_id"].present? && !params["partner_id"].present?
      user_types = UserType.where(customer_type_id: params["customer_type"], franchise_id: params["franchise_id"])
    elsif params["customer_type"].present? && !params["franchise_id"].present? && params["partner_id"].present?
      user_types = UserType.where(customer_type_id: params["customer_type"], partner_id: params["partner_id"])
    elsif params["customer_id"].present? && !params["franchise_id"].present? && !params["partner_id"].present?
      user_types = UserType.where(customer_id: params["customer_id"])    
    end
    
    respond_to do |format|
      format.json do
        render json: user_types
      end
    end
  end
  
  private

    def user_type_params
      params.permit(:user_type_name)
    end

end
