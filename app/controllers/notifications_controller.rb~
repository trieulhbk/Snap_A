class NotificationsController < ApplicationController

	def index
	  	@notifications = Notification.order("created_at DESC").paginate(page: params[:page])
	end
end

