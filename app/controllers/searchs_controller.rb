class SearchsController < ApplicationController
  def search_pin
    @results = []
    @results.clear
    Photo.all.each do |photo|
      if photo.name.include? params[:search]
        @results.push photo
      end
    end
      @photos = @results
  end

  def search_name
    @results = []
    @results.clear
    User.all.each do |user|
      if user.name.include? params[:search]
        @results.push user
      end
    end
      @users = @results
  end

  def search_box
    @results = []
    @results.clear
    Box.all.each do |box|
      if box.name.include? params[:search]
        @results.push box
      end
    end
      @boxes = @results
  end

  def search_page
    search_box
  end

end
