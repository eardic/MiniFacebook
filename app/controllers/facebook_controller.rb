class FacebookController < ApplicationController
  before_filter :authenticate_user, :except => [:home,:profile,:find_friends]

  def home
    @user = User.find(session[:user_id])
  end

  def profile
  end

  def find_friends
  end

  def log_out
    session[:user_id] = nil
    redirect_to login_index_path
  end
end
