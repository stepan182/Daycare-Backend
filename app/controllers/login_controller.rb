class LoginController < ApplicationController
  
  def index
  end
  
  def login
    admin = Admin.find_by(email: params[:txtEmail])
    
    if admin && admin.authenticate(params[:txtPassword])
      login_admin(admin)
      redirect_to '/home'
    else
      flash[:danger] = "Invalid email/password combination"
      redirect_to root_url
    end
    
  end
  
  def logout
    log_out
    redirect_to root_url
  end

end
