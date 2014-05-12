class ProfileController < ApplicationController

  before_filter :authenticate_user

  def update_basic
    @user = User.find(session[:user_id])
    if @user.update_attributes(user_params)
      flash[:notice] = 'The user was saved successfully.'
      puts "Success"
    else
      flash[:notice] = 'The user could not be saved.'
      puts "Fail"
    end
    redirect_to facebook_profile_path
  end

  def add_contact
    @user = User.find(session[:user_id])
    cont = Contact.new(tel: params[:tel], city: params[:city], country: params[:country], address: params[:address])
    @user.contact = cont
    redirect_to facebook_profile_path
  end

  def update_contact
    @user = User.find(session[:user_id])
    @user.contact.uodate_attributes(tel: params[:tel], city: params[:city], country: params[:country], address: params[:address])
    redirect_to facebook_profile_path
  end

  def update_job
    @user = User.find(session[:user_id])
    @user.job.uodate_attributes(company: params[:company], title: params[:title], begin_date: params[:begin], end_date: params[:end])
    redirect_to facebook_profile_path
  end

  def add_job
    @user = User.find(session[:user_id])
    job = Job.new(company: params[:company], title: params[:title], begin_date: params[:begin], end_date: params[:end])
    @user.job = job
    redirect_to facebook_profile_path
  end

  def upload_photo
    if params[:image_id].present?
      preloaded = Cloudinary::PreloadedFile.new(params[:image_id])
      puts 'Invalid upload signature' if !preloaded.valid?
      @user = User.find(session[:user_id])
      @user.img_id = preloaded.identifier
      if @user.save
        puts 'Photo saved successfully'
      else
        puts 'Photo could not uploaded'
      end
    end
    redirect_to facebook_profile_path
  end

  def add_education
    @user = User.find(session[:user_id])
    edu = Education.new(high_school: params[:high_school], college: params[:college])
    @user.education = edu
    redirect_to facebook_profile_path
  end

  def update_education
    @user = User.find(session[:user_id])
    @user.education.update_attributes(high_school: params[:high_school], college: params[:college])
    redirect_to facebook_profile_path
  end

  def delete_friend
    if params[:friend_ids]
      selected_ids = params[:friend_ids]
      user_id = session[:user_id]
      if selected_ids
        @user = User.find(user_id)
        selected_ids.each do |id|
          # Delete from both friend and user of list of friends
          @user.friends.find_by_friend_id(id).destroy
          friend = User.find(id)
          friend.friends.find_by_friend_id(user_id).destroy
        end
      end
    end
    redirect_to facebook_profile_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :last_name, :birth, :gender, :avatar)
  end
end