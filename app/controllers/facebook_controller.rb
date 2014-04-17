class FacebookController < ApplicationController
  before_filter :authenticate_user, :except => [:home, :profile, :find_friends]

  def home
    @user = User.find(session[:user_id])
  end

  def profile
    @user = User.find(session[:user_id])
  end

  def find_friends
  end

  def post_text
    @user = User.find(session[:user_id])
    if @user
      @user.posts.create(post: params[:post])
    end
    render 'home'
  end

  def delete_post
  end

  def get_friends
    @user = User.find(session[:user_id])
    friends = Array.new
    @user.friends.each do |f|
      friends << User.find(f.friend_id)
    end
    return friends
  end

  def log_out
    session[:user_id] = nil
    redirect_to login_index_path
  end
end
