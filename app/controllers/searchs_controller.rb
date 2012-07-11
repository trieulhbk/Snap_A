class SearchsController < ApplicationController
  def search_pin
    @results = []
    @results.clear
    Photo.all.each do |photo|
      if photo.name.downcase.include? params[:search].downcase
        @results.push photo
      end
    end
      @photos = @results
  end

  def search_name
    @results = []
    @results.clear
    User.all.each do |user|
      if user.name.downcase.include? params[:search].downcase
        @results.push user
      end
    end
      @users = @results
  end

  def search_box
    @results = []
    @results.clear
    Box.all.each do |box|
      if box.name.downcase.include? params[:search].downcase
        @results.push box
      end
    end
      @boxes = @results
  end

  def search_page
    search_box
  end

end
