class NotificationsController < ApplicationController
  def mark_as_read
    notification_ids = params[:notification_ids] || []
    notifications = Notification.where(id: notification_ids)
    notifications.update_all(read: true)
  end

  def index
    assigned_issue_ids = Issue.where('assignee LIKE ?', "%#{current_user.id}%").pluck(:id)
    if params[:checked] == 'true'
      @notifications = Notification.where(issue_id: assigned_issue_ids, read: false).order(created_at: :desc)
    else
      @notifications = Notification.where(issue_id: assigned_issue_ids).order(created_at: :desc)
    end
    respond_to do |format|
      format.html
      format.json do
        render json: @notifications.to_json(include: { user: { only: [:first_name] }, issue: { only: [:subject] } })
      end
    end
  end

  def unread_count
    assigned_issue_ids = Issue.where('assignee LIKE ?', "%#{current_user.id}%").pluck(:id)
    unread_count = Notification.where(issue_id: assigned_issue_ids, read: false).count

    render json: { unread_count: unread_count }
  end
end
