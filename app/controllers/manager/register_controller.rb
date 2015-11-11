class Manager::RegisterController < ApplicationController
  layout "manager"

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to '/manager/daycare/new?user_id=' + @user.id.to_s
    else
      flash[:danger] = "Error. Username already exist or email is not correct."
      redirect_to '/manager/register/new'
    end
  end


  private

  def user_params
    params.permit(:name, :username, :password, :email, :country, :address, :customer_id, :is_manager, :is_worker, :is_parent, :user_type_id)
  end

end