class PhotosController < ApplicationController
	before_filter :signed_in_user
	before_filter :authenticated_user, only: [:facebook]

	def index
		@photos = Photo.order("created_at DESC").paginate(page: params[:page],per_page: 15)
	end

	def new
	end

	def pc
		@photo=Photo.new
		store_location
	end

	def url
		@photo=Photo.new
		store_location
	end

	def facebook
		@photo=Photo.new
		token = current_user.authentications.find_by_provider('facebook').access_token

		client = FBGraph::Client.new(:client_id => GRAPH_APP_ID, :secret_id => GRAPH_SECRET, :token => token)
		photos =client.selection.me.photos.limit(0).info!
		@tagged_photos = photos.data.data.map(&:source)
		user =FbGraph::User.me(token)
		@albums=user.albums.map(&:photos);
		store_location

	end

	def create
		@photo=Photo.new(params[:photo])
		if @photo.save
# 			flash[:success] = "Upload new photo successfully"
			@flashfacebook = "Upload new photo successfully"
			respond_to do |format|
				format.html { redirect_back_or upload_path }
				format.js
			end
			# redirect_back_or upload_path

		else
			# flash[:error] = "Upload failed"
			@flashfacebook = "Upload failed"
			respond_to do |format|
				format.html { render 'pc' }
				format.js
			end
			# render 'pc'
		end



	end

	def edit
		@photo=Photo.find(params[:id])
	end

	def update
		@photo = Photo.find(params[:id])
		if @photo.update_attributes(params[:photo])
			flash[:success] = "Photo details updated"
			redirect_to boxes_path
		else
			render 'edit'
		end
	end

	def destroy
		Photo.find(params[:id]).destroy
		flash[:success] = "Photo deleted"
		redirect_to boxes_path
	end

	def authenticated_user
		redirect_to root_path unless !current_user.authentications.find_by_provider('facebook').nil?
	end


end
