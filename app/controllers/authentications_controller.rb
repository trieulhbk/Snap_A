class AuthenticationsController < ApplicationController
  include SessionsHelper
  before_filter :signed_in_user, only: [:destroy]

  def create
    omniauth = auth_hash
    token = omniauth['credentials']['token']
    token_secret = omniauth['credentials']['secret']
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      if !current_user?(authentication.user) && !current_user.nil?
        flash[:info] = "Current #{omniauth['provider']} account is linked to other account. Please sign out #{omniauth['provider']}! "
        redirect_back_or root_path
      else
        # User is already registered with application
        flash[:info] = 'Signed in successfully.'
        sign_in_and_redirect(authentication.user)
      end
    elsif current_user
      # User is signed in but has not already authenticated with this social network
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :access_token => token, :token_secret => token_secret)
      # current_user.apply_omniauth(omniauth)
      current_user.save
      flash[:info] = 'Authentication successful.'
      redirect_back_or edit_user_path(current_user)
    else
      # User is new to this application
      # user = User.new
      authentication = Authentication.new(:provider => omniauth['provider'], :uid => omniauth['uid'], :access_token => token, :token_secret => token_secret)
      session[:authentication] = authentication
      # user.apply_omniauth(omniauth)

      redirect_to signup_path
    end
  end

  def destroy
    # binding.pry
    @authentication = current_user.authentications.find_by_provider(params[:provider]) 
    if @authentication
      @authentication.destroy
      flash[:notice] = 'Successfully destroyed authentication.'
      redirect_to edit_user_path(current_user)
    else
      flash[:notice] = "Authentication for #{params[:provider]} not found. "
      redirect_to root_path
    end
  end

  def auth_hash
    request.env['omniauth.auth']
  end

  private
  def sign_in_and_redirect(user)
    sign_in user
    redirect_to root_path
  end
end
