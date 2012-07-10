class ReportsController < ApplicationController

 def create
  if params[:photo]
    Report.create(source_id: current_user.id,target_id: params[:photo],title: "user_report_photo")
  end
  if params[:user]
    Report.create(source_id: current_user.id,target_id: params[:user],title: "user_report_user")
  end
  redirect_to admin_photos_path
 end

 def index
    @reports = Report.order("created_at DESC").paginate(page: params[:page])
 end

 def destroy
    Report.find(params[:id]).destroy
    flash[:success] = "Report deleted"
    redirect_to admin_reports_path
 end

  def execute
    @report = Report.find(params[:id])
    if @report.title == "user_report_photo"
      Photo.find(@report.target_id).destroy
    end
    if @report.title == "user_report_user"
      User.find(@report.target_id).destroy
    end
    @report.destroy
    redirect_to admin_reports_path
  end
end

