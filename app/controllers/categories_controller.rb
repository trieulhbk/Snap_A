class CategoriesController < ApplicationController

  def index
    store_location
    @photos=[]
    if params[:category_id].nil? || Category.count < params[:category_id].to_i
      Category.all.each do |c|
        c.boxes.each do |b|
          @photos.concat b.photos

          # b.photos.each do |p|
          # @photos.push p
          # end
        end
      end
    else
      @category = Category.find(params[:category_id])
      @category.boxes.each do |b|
        @photos.concat b.photos

        # b.photos.each do |p|
        # @photos.push p
        # end
      end
    end
    @photos = @photos.sort_by{|t| - t.created_at.to_i}
    @photos = @photos.paginate(page: params[:page], per_page: 15)
  end

  def show
  end

end
