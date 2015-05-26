module LoginHelper
  
  def login_admin(admin)
    session[:admin_name] = admin.name
  end
  
  def logged_in?
    !session[:admin_name].nil?
  end
  
  def authorize
    if !logged_in?
      redirect_to login_url
    end
  end
  
  def log_out
    session.delete(:admin_name)
  end
  
end
