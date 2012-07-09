class ReportsController < ApplicationController
 def index
    @reports = Report.order("created_at DESC").paginate(page: params[:page])
  end
end

