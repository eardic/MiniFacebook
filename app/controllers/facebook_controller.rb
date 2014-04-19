class FacebookController < ApplicationController
  before_filter :authenticate_user, :except => [:home, :profile, :find_friends]

  def home
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to login_index_path
    end
  end

  def friend_profile
    @user = User.find(session[:user_id])
    @friend = User.find(params[:friend_id])
  end

  def add_friend
    if params[:id]
      @user = User.find(session[:user_id])
      @user.friends.create(friend_id: params[:id])
    end
    render 'profile'
  end

  def find_friends
    @user = User.find(session[:user_id])
    @friends = User.search(params[:src_term])
    @user.friends.each do |u|
      @friends.select { |f| f.id == u.friend_id }.each do |d|
        @friends.delete(d)
      end
    end
  end

  def profile
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to login_index_path
    end
  end

  def post_text
    @user = User.find(session[:user_id])
    if @user
      @user.posts.create(post: params[:post])
    end
    render 'home'
  end

  def delete_post
    if params[:post_id]
      @user = User.find(session[:user_id])
      @user.posts.find(params[:post_id]).destroy
    end
    render 'home'
  end

  def log_out
    session[:user_id] = nil
    redirect_to login_index_path
  end

  def user_params
    params.require(:user).permit(:name, :last_name, :birth, :gender)
  end
end
