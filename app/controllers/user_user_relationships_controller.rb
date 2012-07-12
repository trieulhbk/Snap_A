class UserUserRelationshipsController < ApplicationController

	def create

    @user = User.find(params[:user_user_relationship][:following_id])
    if !current_user.following?(@user)
      current_user.follow!(@user)
    @boxes = @user.boxes

    respond_to do |format|
      format.html { redirect_back_or @user }
      format.js
    end

    end
  end

  def destroy
    @user = UserUserRelationship.find(params[:id]).following
    current_user.unfollow!(@user)
    @boxes = @user.boxes

    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
