class UsersController < ApplicationController
  include SessionsHelper

  before_filter :signed_in_user, only: [:index,:edit,:update,:destroy, :following, :followers]
  before_filter :correct_user, only: [:edit,:update]
  before_filter :admin_user, only: :destroy
  before_filter :create_user, only: [:create,:new]
  before_filter :auth_user, only: [:new]

  def index
    @allusers = User.all
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @boxes = @user.boxes
    @count_photo = 0
    @user.boxes.each do |box|
      @count_photo += box.photos.count
    end
    @count_like = 0
    @user.user_photo_actions.each do |r|
      if r.action == :like
        count_like += 1
      end
    end
  end

  def send_invite
    UserMailer.invite(params[:email]).deliver
    redirect_to root_path
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
  end

  def following
    @user = User.find(params[:id])
    @following = @user.following_users
  end

  def photos
    @photos = []
    @user = User.find(params[:id])
    @user.boxes.each do |box|
      @photos[@photos.length..@photos.length] = box.photos
    end


  end

  def likedphotos
    @user = User.find(params[:id])
    @photos = @user.action_photos
  end


  def new

  end

  def create
    @user = User.new(params[:user])
    authentication = session[:authentication]
    if authentication
      @user.authentications << authentication
      session.delete :authentication
    end
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Snap"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    @current_user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to users_path
  end

  def toggle_active
    if current_user.active
      current_user.update_attribute("active",false)
    else
      current_user.update_attribute("active",true)
    end
    sign_in current_user
    redirect_to edit_user_path(current_user)
  end

  def admin_page

  end

  private

  def auth_user
    authentication = session[:authentication]
    @user = User.new
    if authentication
      token = authentication.access_token
      token_secret = authentication.token_secret
      if authentication.provider == 'facebook'
        client = FBGraph::Client.new(:client_id => GRAPH_APP_ID, :secret_id => GRAPH_SECRET, :token => token)
        user = client.selection.me
        name = user.info!.name
        email = user.info!.email
      else
        Twitter.configure do |config|
          config.consumer_key = TWITTER_APP_ID
          config.consumer_secret = TWITTER_SECRET
          config.oauth_token = token
          config.oauth_token_secret = token_secret
        end
        name = Twitter.user.name
        email = ""
      end
      @user = User.new(:name => name, :email => email)
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def create_user
    if signed_in?
      redirect_to(root_path)
    end
  end
end
