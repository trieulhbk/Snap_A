class StaticPagesController < ApplicationController
  def home
    @set = []
    if signed_in?
      Notification.all.each do |noti|
        if noti.source_id == current_user.id && noti.relation_type == "user_user_relationships"
         t_user = User.find(noti.target_id)
         t_user.boxes.each do |box|
          @set.concat box.photos.order("created_at")
         end
        end
      end
      @photos = @set.paginate(page: params[:page])
    end
  end

  def about
  end

end
