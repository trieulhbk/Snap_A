class UserBoxFollowsController < ApplicationController
	def create
  	# find box
    
    box_id = params[:user_box_follow][:box_id]
    
  	@box = Box.find(box_id)
    if @box == nil
      a
    end
    
    # @id = UserBoxFollow.find_by_box_id(box_id).id
  	current_user.follow_box!(@box)
  	respond_to do |format|
  		format.html { redirect_to @user }
  		format.js
  	end
  end

  def destroy
  	@box = UserBoxFollow.find(params[:id]).box

    if @box == nil
      a
    end

  	current_user.unfollow_box!(@box)
  	respond_to do |format|
  		format.html { redirect_to @user }
  		format.js
  	end
  end
end