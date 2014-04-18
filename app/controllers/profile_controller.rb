class ProfileController < ApplicationController

  def update_basic
    @user = User.find(session[:user_id])
    if @user.update_attributes(user_params)
      flash[:notice] = 'The user was saved successfully.'
      puts "SUCCESSS"
    else
      flash[:notice] = 'The usercould not be saved.'
      puts "FAILLLLL"
    end
    redirect_to facebook_profile_path
  end

  def update_contact
    @user = User.find(session[:user_id])
    if @user.contact
      flash[:notice] = 'The user was saved successfully.'
      puts "SUCCESSS"
    else
      flash[:notice] = 'The usercould not be saved.'
      puts "FAILLLLL"
    end
  end

  def update_jobs

  end

  def upload_photo
    if params[:image_id].present?
      preloaded = Cloudinary::PreloadedFile.new(params[:image_id])
      puts "Invalid upload signature" if !preloaded.valid?
      @user = User.find(session[:user_id])
      @user.img_id = preloaded.identifier
      if @user.save
        puts "HeLLOOOOOOOOOOOOOOO"
      else
        puts "NOOOOOOOOO"
      end
    end
    puts "AQQQQQQQQQQQQ"
    redirect_to facebook_profile_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :last_name, :birth, :gender, :avatar)
  end
end