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
end
