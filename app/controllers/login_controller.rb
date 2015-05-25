class LoginController < ApplicationController
  
  def index
  end
  
  def login
    @admin = Admin.find_by(email: params[:txtEmail])
    
    if @admin
      flash[:message] = "Admin found"
      redirect_to '/home'
    else
      flash[:message] = "Admin not found"
      redirect_to '/'
    end
    
  end
end
