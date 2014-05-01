module FacebookHelper
  def get_friends
    User.get_friends(session[:user_id])
  end

  def get_user(id)
    User.find(id)
  end

  def get_home_posts
    user = User.find(session[:user_id])
    f_ids = Array.new
    @user.friends.each do |f|
      f_ids << f.friend_id
    end
    friend_posts = Post.where(user_id: f_ids) # get posts using ids of friends
    user_posts = Post.where(user_id: user.id) # add posts of user
    home_posts = friend_posts.merge user_posts
    return home_posts.order(created_at: :desc)
  end

  def is_friend(id)
    !User.find(session[:user_id]).friends.where(:friend_id => id).empty?
  end

  def is_request_sent(id)
    !User.find(id).requests.where(:from_user_id => session[:user_id]).empty?
  end

end
