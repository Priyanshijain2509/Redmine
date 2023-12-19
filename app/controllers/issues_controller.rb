class IssuesController < ApplicationController
  before_action :set_project, only: %i[edit update new show]

  def index
    @current_project = Project.find(params[:project_id])
    @issues = @current_project.issues
    session[:current_project_id] = @current_project.id if @current_project
  end

  def show
    @issue = Issue.find_by(id: params[:id])
    @current_project = Project.find(params[:project_id])
    session[:current_project_id] = @current_project.id if @current_project
  end

  def new
    @project = Project.find_by(id: params[:project_id])
    @issue = Issue.new
  end

  def create
    @project = Project.find_by(id: params[:project_id])
    @issue = Issue.new(issue_params)
    @issue.assignee = params[:issue][:assignee]
    issue_assigned_to = @issue.assignee
    @issue.assignee.reject!(&:empty?)
    if @issue.save
      send_issue_assigned_mail(issue_assigned_to)
      redirect_to user_project_issues_path
    else
      flash[:alert] = "Issue can't be posted"
      redirect_to new_user_project_issue_path
    end
  end

  def edit
    @issue = Issue.find_by(id: params[:id])
  end

  def update
    @issue = Issue.find_by(id: params[:id])
    @previous_assignee = @issue.assignee
    new_assignee = []
    removed_assignee = []

    @issue.assignee.reject!(&:empty?)
    if @issue.update(edit_issue_params)
      changes = @issue.saved_changes
      notification_data(changes)
      @updated_assignee = params[:issue][:assignee]
      removed_assignee = @previous_assignee - @updated_assignee
      new_assignee = @updated_assignee - @previous_assignee

      send_issue_assigned_mail(new_assignee) unless new_assignee.empty?
      send_removed_from_issue(removed_assignee) unless removed_assignee.empty?

      flash[:notice] = 'Issue updated!'
      redirect_to user_project_issue_path
    else
      flash[:error] = 'Error in updating issue.'
      redirect_to user_project_issue_path
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

  def my_page
    all_issues = Issue.all
    @issues = all_issues.select {
      |issue| issue.assignee.include?(current_user.id.to_s)
    }
  end

  def reported_issue
    @issues = Issue.where(user_id: current_user.id)
  end

  def add_label
    @issue = Issue.find(params[:id])
    label = params[:issue][:issue_status]
    color = params[:issue][:color]
    new_label = [label, color]

    if @issue.update(issue_status: @issue.issue_status + [new_label])
      flash[:notice] = 'Label Added'
    else
      flash[:alert] = 'Label not added'
    end
    redirect_to user_project_issue_path
  end

  def remove_label
    @issue = Issue.find(params[:id])
    label_to_remove = params[:label]
    current_issue_status = @issue.issue_status
    current_issue_status.reject! { |label| label[0] == label_to_remove }
    @issue.update(issue_status: current_issue_status)
    redirect_to request.referrer
  end

  def resolved
    @issue = Issue.find(params[:id])
    if @issue.issue_resolved == true
      @issue.update(issue_resolved: false)
    else
      @issue.update(issue_resolved: true)
    end
    redirect_to user_project_issue_path(user_id: params[:user_id],
      project_id: params[:project_id], id: @issue)
  end

  private

  def issue_params
    params.require(:issue).permit(:tracker, :subject, :issue_description,
    :category, :start_date, :end_date, :estimated_time, :issue_resolved,
    :project_id, :user_id, :issue_status => [], :assignee => [], files: [])
  end

  def edit_issue_params
    params.require(:issue).permit(:tracker, :subject, :issue_description,
    :category, :end_date, :estimated_time,
    :project_id, :assignee => [], files: [])
  end

  def add_label_params
    params.require(:issue).permit(:issue_status, :color)
  end

  def set_project
    @project = Project.find_by(id: params[:project_id])
  end

  def send_issue_assigned_mail(issue_assigned_to)
    issue_assigned_to.each do |user_id|
      next if user_id.blank?
      user = User.find(user_id)
      IssueMailer.issue_assigned(user, current_user, @project, @issue).deliver_now
    end
  end

  def send_removed_from_issue(removed_assignee)
    removed_assignee.each do |user_id|
      user = User.find(user_id)
      IssueMailer.removed_from_issue(user, current_user, @project, @issue).deliver_now
    end
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
