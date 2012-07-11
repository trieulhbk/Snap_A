class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      unless @user.verify?
        redirect_to root_path, notice: "Please verify your email!" 
      else
        sign_in @user
        redirect_back_or root_path
      end
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
