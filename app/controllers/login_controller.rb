class LoginController < ApplicationController

  before_filter :authenticate_user, :except => [:index, :create, :login_try, :new]
  before_filter :save_login_state, :only => [:new, :create, :index, :login_try]

  #Sing Up Form
  def new
    @user = User.new
  end

  # Registration method
  def create
    @user = User.new(user_params)
    if (@user.save)
      session[:user_id] = @user.id
      flash[:notice] = "Welcome, you logged in as #{@user.name}"
      redirect_to facebook_home_path
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
      flash[:status]= "invalid"
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
