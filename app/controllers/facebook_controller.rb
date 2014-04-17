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

# PROFILE EDIT METHODS
  def update_basic
    @user = User.find(session[:user_id])
    if @user.update_attributes(user_params)
      flash[:notice] = 'The user was saved successfully.'
      puts "SUCCESSS"
    else
      flash[:notice] = 'The usercould not be saved.'
      puts "FAILLLLL"
    end
    render "profile"
  end

  def add_job
  end
  def update_job
  end

  def add_edu
  end
  def update_edu
  end

  def delete_friend(id)
  end
  def add_friend(id)
  end
  def find_friends
  end

  def add_contact
  end
  def update_contact
  end
# END OF PROFILE EDIT

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

  private
  def user_params
    params.require(:user).permit(:name, :last_name, :birth, :gender)
  end
end
