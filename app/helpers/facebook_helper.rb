module FacebookHelper
  def get_friends
    User.get_friends(session[:user_id])
  end
end
