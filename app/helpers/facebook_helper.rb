module FacebookHelper
  def get_friends
    User.get_friends(session[:user_id])
  end

  def get_user(id)
    User.find(id)
  end

end
