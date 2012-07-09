class BoxesController < ApplicationController
  def create

    b = params[:box]
    if b == nil
      a
    end


    name = params[:box][:name]

    if name == nil
      b
    end

    @box = current_user.boxes.build(name: name)

    if @box.save
      follower_follow_this_box(@box)
      # redirect_to root_path
      redirect_back_or(root_path)
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
  end

  def delete
  end

  def edit
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
