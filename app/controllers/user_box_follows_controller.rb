class UserBoxFollowsController < ApplicationController
  def create
    # find box

    box_id = params[:user_box_follow][:box_id]

    @box = Box.find(box_id)
    if @box == nil
      a
    end
    if !current_user.following_box?(@box)
      current_user.follow_box!(@box)
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
      end

    end
  end

  def destroy
    @box = UserBoxFollow.find(params[:id]).box

    current_user.unfollow_box!(@box)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
