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

  def edit
    @issue = Issue.find_by(id: params[:id])
  end

  def delete
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
