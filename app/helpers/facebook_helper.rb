module FacebookHelper
  def get_friends
    User.get_friends(session[:user_id])
  end

  # for comment partial view, to check whether a comment belongs to user or not
  def get_user_id
    session[:user_id]
  end

  def get_user(id)
    User.find(id)
  rescue ActiveRecord::RecordNotFound
    null
  end

  def create_notif_text(type)
    case type
      when 0
        "updated his status"
      when 1
        "like your post"
      when 3
        "commented on your post"
      when 4
        "created an event"
    end
  end

  def get_n_messages(user, num = 3)
    f_ids = Array.new
    user.friends.each do |f|
      f_ids << f.friend_id
    end
    Message.where("user_id in (?) and to_user_id = #{user.id} or user_id = #{user.id}", f_ids).
        order(created_at: :desc).limit(num)
  end

  # returns last message between user and friend
  def get_last_message(to_id, from_id)
    u_msg = User.find(to_id).messages.where(to_user_id: from_id).last
    f_msg = User.find(from_id).messages.where(to_user_id: to_id).last
    if f_msg != nil && u_msg != nil
      if f_msg.created_at > u_msg.created_at
        return f_msg
      else
        return u_msg
      end
    elsif f_msg == nil && u_msg != nil
      u_msg
    elsif u_msg == nil && f_msg != nil
      f_msg
    end
    nil
  end

  def get_home_posts
    user = User.find(session[:user_id])
    f_ids = Array.new
    f_ids << user.id
    @user.friends.each do |f|
      f_ids << f.friend_id
    end
    Post.where(user_id: f_ids).order(updated_at: :desc) # get posts using ids of friends
  end

  def is_friend(id)
    !User.find(session[:user_id]).friends.where(:friend_id => id).empty?
  end

  def is_request_sent(id)
    !User.find(id).requests.where(:from_user_id => session[:user_id]).empty?
  end

end
