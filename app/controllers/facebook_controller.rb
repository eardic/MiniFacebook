class FacebookController < ApplicationController
  before_filter :authenticate_user, :except => [:home, :profile, :find_friends]

  def home
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to login_index_path
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
  end

  def log_out
    session[:user_id] = nil
    redirect_to login_index_path
  end

  def user_params
    params.require(:user).permit(:name, :last_name, :birth, :gender)
  end
end
