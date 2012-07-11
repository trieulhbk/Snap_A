class SessionsController < ApplicationController
  before_filter :verified_user, only: [ :create]

  def new

  end

  def create
    if @user && @user.authenticate(params[:password])
      sign_in @user
      redirect_back_or root_path
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  def verified_user
    @user = User.find_by_email(params[:email])
    redirect_to root_path, notice: "Please verify your email!" unless @user.verify?
  end
end
