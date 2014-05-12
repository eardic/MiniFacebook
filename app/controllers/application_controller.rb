class ApplicationController < ActionController::Base
  helper :all
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protected
  def authenticate_user
    id = session[:user_id]
    if id.nil? || User.where(id: id).empty?
      redirect_to login_index_path
      return false
    else
      return true
    end
  end

  #This method for prevent user to access Signup & Login Page without logout
  def save_login_state
    id = session[:user_id]
    if id && !User.where(id: id).empty?
      redirect_to facebook_home_path
      return false
    else
      return true
    end
  end

end
