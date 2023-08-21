class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.order(created_at: :desc)
    @notifications.where(checked: false).each do |notification| #未読の通知を探してnotificationに代入
      notification.update(checked: true) #通知を既読に更新
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_to notifications_path
  end
end
