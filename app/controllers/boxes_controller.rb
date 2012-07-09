class BoxesController < ApplicationController

  def index
    @user=current_user
    @boxes=@user.boxes.all
  end

  def create

    b = params[:box]
    if b == nil
      a
    end


    name = params[:box][:name]

    if name == nil
      b
    end

    @box = current_user.boxes.build(name: name, category_id: params[:box][:category_id])

    if @box.save
      follower_follow_this_box(@box)
      # redirect_to root_path
      redirect_to upload_path
    else
      # @micropost = current_user.microposts.build(params[:micropost])
      # if @micropost.save
      #   flash[:success] = "Micropost created!"
      #   redirect_to root_path
      # else
      render 'static_pages/home'
      # end
    end
  end

  def show
    @user=current_user
    @box=@user.boxes.find(params[:id])
    @photos=@box.photos.all
  end

  def delete
  end


  def edit
    @box = Box.find(params[:id])
  end

  def update
    @box = Box.find(params[:id])
    if @box.update_attributes(params[:user])
      flash[:success] = "Box info updated"
      redirect_back_or @box
    else
      render 'edit'
    end
  end


  private
  def follower_follow_this_box(box)
    followers = current_user.followers
    if followers != nil
      followers.each do |follower|
        follower.follow_box!(box)
      end
    end
  end
end
