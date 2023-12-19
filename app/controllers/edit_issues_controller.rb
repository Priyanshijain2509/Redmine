class EditIssuesController < ApplicationController
  before_action :set_issue, only: %i[create edit update]

  def index; end

  def create
    @edit_issue = EditIssue.new(edit_issue_params)
    if @edit_issue.save
      flash[:notice] = 'Successfully updated!'
      redirect_to request.referrer
    else
      flash[:error] = "Can't be updated!"
      render 'new'
    end
  end

  def edit
    @edit_issue = @issue.edit_issues.find_by(id: params[:edit_issue_id])
  end

  def update
    @edit_issue = @issue.edit_issues.find_by(id: params[:edit_issue][:edit_issue_id])
    if @edit_issue.update(edit_issue_params)
      changes = @edit_issue.notes.saved_changes
      notification_data(changes)
      flash[:notice] = 'Successfully updated!'
      redirect_to user_project_issue_path(id: params[:issue_id])
    else
      flash[:error] = "Can't be updated!"
      render 'edit'
    end
  end

  def destroy
    @edit_issue = EditIssue.find_by(id: params[:id])
    if @edit_issue.destroy
      flash[:notice] = 'Successfully deleted!'
    else
      flash[:error] = 'Error deleting it.'
    end
    redirect_to request.referrer
  end

  def fetch_issue_data
    @edit_issue = EditIssue.find_by(id: params[:edit_issue_id])
    if @edit_issue
      render json: { edit_issue: @edit_issue.as_json }
    else
      render json: { error: 'EditIssue not found' }, status: :not_found
    end
  end

  private

  def set_issue
    @issue = Issue.find_by(id: params[:id])
  end

  def edit_issue_params
    params.require(:edit_issue).permit(:notes, :updated_by, :issue_id, :project_id)
  end

  def notification_data(changes)
    changes.each do |attribute, values|
      next if attribute == 'updated_at'
      old_value, new_value = values
      notification_data = {
        attr_change: attribute,
        new_data: new_value,
        read: false,
        issue_id: @issue.id,
        user_id: current_user.id
      }
      Notification.create(notification_data)
    end
  end
end
