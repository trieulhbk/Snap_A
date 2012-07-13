class VerificationsController < ApplicationController
  before_filter :load_user_using_persistence_token

  def resend
    deliver_verification_instructions(@user)
    flash[:notice] = "Email has been resend."
  end

  def show
    if @user
      @user.verify!
      flash[:notice] = "Thank you for verifying your account."
      sign_in @user
    end
    redirect_back_or root_path
  end

  private

  def load_user_using_persistence_token
    @user = User.find_by_persistence_token(params[:id])
    flash[:notice] = "Unable to find your account." unless @user
  end

end
