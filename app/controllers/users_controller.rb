class UsersController < ApplicationController
  include SessionsHelper

  before_filter :signed_in_user, only: [:index,:edit,:update,:destroy, :following, :followers]
  before_filter :correct_user, only: [:edit,:update]
  before_filter :admin_user, only: :destroy
  before_filter :create_user, only: [:create,:new]

  def index
    @allusers = User.all
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @boxes = @user.boxes
  end

  def new
    authentication = session[:authentication]
    if authentication
      token = authentication.access_token
      client = FBGraph::Client.new(:client_id => GRAPH_APP_ID, :secret_id => GRAPH_SECRET, :token => token)
      user = client.selection.me
      name = user.info!.name
      email = user.info!.email
      @user = User.new(:name => name, :email => email)
    else
      @user = User.new
    end
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
      flash[:success] = "Welcome to Sample App"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in current_user
      redirect_to current_user
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

  private

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
