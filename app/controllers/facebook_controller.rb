class FacebookController < ApplicationController
  respond_to :html, :js
  before_filter :authenticate_user, :except => [:home, :profile, :find_friends]
  @@clicked_friend_id = nil # for messaging system, messages will be sent to selected user in inbox list

  def home
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to login_index_path
    end
  end

  def send_message
    f_id = @@clicked_friend_id
    u_id = session[:user_id]
    msg = params[:message]
    if f_id && msg
      @user = User.find(u_id)
      @friend = User.find(f_id)
      @message = Message.new(to_user_id: f_id, message: msg, user_id: u_id)
      @user.messages << @message
      @user.save
    end
    render 'send_message.js'
  end

  def get_messages
    f_id = params[:friend_id]
    @@clicked_friend_id = f_id
    u_id = session[:user_id]
    if f_id
      @user = User.find(u_id)
      @friend = User.find(f_id)
      f_msgs = @friend.messages.take(25).select { |m| m.to_user_id == u_id.to_i } # messages friend send to user
      u_msgs = @user.messages.take(25).select { |m| m.to_user_id == f_id.to_i } # messages user send to friend
      @messages = u_msgs + f_msgs # merge all messages
      #@messages.sort_by(&:created_at)
    end
    render 'show_message.js'
  end

  def friend_profile
    @user = User.find(session[:user_id])
    @friend = User.find(params[:friend_id])
  end

  def add_friend
    if params[:friend_id]
      @user = User.find(session[:user_id])
      @user.friends.create(friend_id: params[:friend_id])
      @request = Request.find(params[:request_id])
      @request.destroy
    end
    render 'answer_request.js'
  end

  def deny_request
    if params[:request_id] #request id
      @request = Request.find(params[:request_id])
      @request.destroy
    end
    render 'answer_request.js'
  end

  def send_request
    if params[:id]
      @user = User.find(session[:user_id])
      @friend = User.find(params[:id])
      @friend.requests.create(from_user_id: @user.id)
    end
    render 'send_request.js'
  end

  def find_friends
    @user = User.find(session[:user_id])
    @friends = User.search(params[:src_term])
    @user.friends.each do |u|
      @friends.select { |f| f.id == @user.id }.each do |d|
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
    @is_home = params[:is_home] == "true"
    if @user
      @user.posts.create(post: params[:post])
    end
    render 'post_text.js'
  end

  def like_post
    if params[:post_id]
      @user = User.find(session[:user_id])
      @post = Post.find(params[:post_id])
      like true, @post
    end
    render 'like_post.js'
  end

  def dislike_post
    if params[:post_id]
      @user = User.find(session[:user_id])
      @post = Post.find(params[:post_id])
      like false, @post
    end
    render 'like_post.js'
  end

  def share_post
    p_id = params[:post_id]
    if p_id
      @user = User.find(session[:user_id])
      posts = @user.posts.select { |p| p.id == p_id }
      if posts.empty?
        text = Post.find(p_id).post
        @user.posts.create(post: text)
      end
    end
    render 'profile'
  end

  def add_comment
    p_id = params[:post_id]
    comment = params[:comment]
    if p_id && comment
      @user = User.find(session[:user_id])
      @post = Post.find(p_id)
      @user.comments.create(post_id: p_id, text: comment)
    end
    render 'add_comment.js'
  end

  def delete_comment
    if params[:comment_id]
      @comment = Comment.find(params[:comment_id])
      @comment.destroy
    end
    render 'delete_comment.js'
  end

  def delete_post
    if params[:post_id]
      @user = User.find(session[:user_id])
      @post = @user.posts.find(params[:post_id])
      @post.destroy
    end
    render 'delete_post.js'
  end

  def log_out
    session[:user_id] = nil
    redirect_to login_index_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :last_name, :birth, :gender)
  end

  def like(is_like, post)
    if post # not null
      if is_like # like or dislike
        count = post.like # get like count
        if count # increment
          count += 1
        else # initialize
          count = 1
        end
        post.like = count # set like count
      else
        count = post.dislike # get dislikes
        if count # modify
          count -= 1
        else
          count = -1
        end
        post.dislike = count # set dislikes
      end
      post.save # save like or dislike count to db
      puts "saved post"
      puts post.post
      puts post.like
      puts post.dislike
    end
  end
end
