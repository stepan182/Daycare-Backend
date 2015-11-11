class Manager::LoginController < ApplicationController

  def index
  end

  def login
    manager = User.find_by(username: params[:txtUserName])

    if manager && manager.is_manager=="yes" && manager.authenticate(params[:txtPassword])
      login_manager(manager)
      redirect_to '/manager/home'
    else
      flash[:danger] = "Invalid username/password combination"
      redirect_to manager_login_url
    end

  end

  def logout
    manager_log_out
    redirect_to manager_login_url
  end

  def forgot_password
    admin = Admin.find_by(email: params["email"])

    if admin
      AdminMailer.forgot_password(admin).deliver

      flash[:info] = "Password reset link has been sent to your email"
      redirect_to '/login'
    else
      flash[:danger] = "Invalid email"
      redirect_to '/login'
    end
  end

  def password_reset
  end

  def do_reset
    if params["password"] == params["password_confirmation"]

      admin = Admin.find_by(email: params["email"])
      if admin && admin.password_digest[0..20] == params["token"] && admin.update_attributes(admin_params)
        flash[:success] = "Password updated. You can login using your new password"
        redirect_to '/login'
      else
        flash.now[:danger] = "Couldn't update. Verify your token."
        render 'password_reset'
      end

    else
      flash.now[:danger] = "Passwords do not match"
      render 'password_reset'
    end
  end


  private

  def admin_params
    params.permit(:password, :password_confirmation)
  end

end
