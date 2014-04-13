class LoginController < ApplicationController

  before_filter :authenticate_user, :except => [:index, :create, :login_try, :welcome, :new]
  before_filter :save_login_state, :only => [:new, :create, :index, :login_try, :welcome]

  #Sing Up Form
  def new
    @user = User.new
  end

  # Welcome page
  def welcome
    @user
  end

  # Registration method
  def create
    @user = User.new(user_params)
    if (@user.save)
      render "welcome"
    else
      render "new"
    end
  end

  def login_try
    authorized_user = User.find_by(mail: params[:mail])
    if authorized_user && authorized_user.password == params[:password]
      session[:user_id] = authorized_user.id
      flash[:notice] = "Welcome, you logged in as #{authorized_user.name}"
      redirect_to facebook_home_path
    else
      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      render "index"
    end
  end

  # Login Page
  def index
  end

  private
  def user_params
    params.require(:user).permit(:name, :last_name, :mail, :password, :birth, :gender)
  end
end
