class ApplicationController < ActionController::Base
  helper :all
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protected
  def authenticate_user
    unless session[:user_id]
      redirect_to login_index_path
      return false
    else
      # set current_user by the current user object
      @current_user = User.find session[:user_id]
      return true
    end
  end

  #This method for prevent user to access Signup & Login Page without logout
  def save_login_state
    if session[:user_id]
      redirect_to facebook_home_path
      return false
    else
      return true
    end
  end
end
