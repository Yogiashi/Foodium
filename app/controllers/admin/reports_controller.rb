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
      redirect_to admin_reports_path, notice: "通報ステータスの変更に成功しました。"
    else
      render :show
    end
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    redirect_to admin_reports_path, notice: "通報の削除に成功しました。"
  end

  private
  def report_params
    params.require(:report).permit(:status)
  end
end
