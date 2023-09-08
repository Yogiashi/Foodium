class Admin::ReportsController < ApplicationController

  def index
    @reports = Report.all.page(params[:page]).per(15).order(created_at: :desc)
  end

  def show
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    if @report.update(report_params)
      redirect_to admin_report_path(@report)
    else
      render :edit
    end
  end

  private
  def report_params
    params.require(:report).permit(:status)
  end
end
