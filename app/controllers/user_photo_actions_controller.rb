class UserPhotoActionsController < ApplicationController
	def create
		photo_id = params[:user_photo_action][:photo_id]

		@photo = Photo.find(photo_id)
		if @photo == nil
			a
		end
		if !current_user.liked_photo?(@photo)
			current_user.act_on_photo!(@photo, :like)
			respond_to do |format|
				format.html { redirect_to @photo }
				format.js
			end

		end

	end

	def destroy

		@photo = UserPhotoAction.find(params[:id]).photo
		current_user.un_act_on_photo!(@photo, :like)
		respond_to do |format|
			format.html { redirect_to @photo }
			format.js
		end

	end

end
