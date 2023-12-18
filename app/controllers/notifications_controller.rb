class NotificationsController < ApplicationController
  def mark_as_read
    notification_ids = params[:notification_ids] || []
    notifications = Notification.where(id: notification_ids)
    notifications.update_all(read: true)
  end
end
