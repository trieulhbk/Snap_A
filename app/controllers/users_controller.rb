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
    @new_box = @user.boxes.build
    store_location
  end

  # def show_by_name
  #   @user = User.find_by_name(params[:name])
  #   render 'show'
  # end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
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
