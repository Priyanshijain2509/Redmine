class IssuesController < ApplicationController
  before_action :set_project, only: %i[index edit update new show]

  def index
    @issues = @project.issues
  end

  def show
    @issue = Issue.find_by(id: params[:id])
  end

  def new
  end

  def create
    @issue = Issue.new(issue_params)
    if @issue.save
      flash[:notice] = 'Issue Posted!'
      redirect_to user_project_issues_path
    else
      flash[:error] = "Issue can't be posted"
      render 'new'
    end
  end

  def edit
    @issue = Issue.find_by(id: params[:id])
  end

  def update
    @issue = Issue.find_by(id: params[:id])
    if @issue.update(issue_params)
      flash[:notice] = 'Issue updated!'
      redirect_to user_project_issue_path
    else
      flash[:error] = "Error in updating issue."
      render 'edit'
    end
  end

  def destroy
    @issue = Issue.find(params[:id])
    file_id = params[:file_id]
    attachment = @issue.files.find_by(id: file_id)
    attachment.purge if attachment.present?
    flash[:notice] = 'File deleted successfully'
    redirect_to user_project_issue_path(user_id: @issue.user.id,
      project_id: @issue.project_id, id: @issue.id)
  end

  private

  def issue_params
    params.require(:issue).permit(:tracker, :subject, :issue_description,
    :issue_status, :category, :start_date, :end_date, :estimated_time, :assignee,
    :project_id, :user_id, files: [])
  end

  def set_project
    @project = Project.find_by(params[:project_id])
  end
end
