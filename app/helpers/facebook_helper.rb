module FacebookHelper
  def get_friends
    User.get_friends(session[:user_id])
  end

  def get_user(id)
    User.find(id)
  end

  def is_friend(id)
    !User.find(session[:user_id]).friends.where(:friend_id => id).empty?
  end

  def is_request_sent(id)
    !User.find(id).requests.where(:from_user_id => session[:user_id]).empty?
  end

end
