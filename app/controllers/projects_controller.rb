class ProjectsController < ApplicationController

  def index
    @projects = current_user.projects.all
  end

  def new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:notice] = 'Project successfully created!'
      redirect_to user_projects_path
    else
      flash[:alert] = 'Error creating the project.'
      render :new
    end
  end

  def show
    @id = params[:id]
  end

  def edit
    @project = Project.find_by(id: params[:id])
    @users = User.where('email LIKE ?', "%#{params[:search_email]}%")
  end

  def update
    @project = Project.find_by(id: params[:id])
    existing_assigned_to = @project.assigned_to || []
    updated_assigned_to = existing_assigned_to | project_params[:assigned_to]

    if @project.update(assigned_to: updated_assigned_to)
      update_assigned_projects(project_params[:assigned_to], @project.id)
      flash[:notice] = 'Contributor added!'
      redirect_to user_project_issues_path(project_id: params[:id])
    else
      flash[:error] = 'Error in adding contributors.'
      redirect_to edit_user_project_path
    end
  end

  def remove_assigned_user
    @project = Project.find(params[:id])
    user_id = params[:user_id]
    user = User.find(user_id)

    if @project.assigned_to.include?(user_id)
      @project.assigned_to.delete(user_id)
      @project.save
      update_removed_user_projects(user, @project.id)
    else
      flash[:alert] = "Can't be removed!"
    end
    redirect_to edit_user_project_path(user_id: current_user.id, id: @project.id)
  end

  def activity
    @project = Project.find_by(id: params[:project_id])
    session[:current_project_id] = @project.id if @project
  end

  def roadmap
    @project = Project.find_by(id: params[:project_id])
    session[:current_project_id] = @project.id if @project
  end

  def overview
    if params[:project_view].present? && params[:project_view] == 'true'
      @project = current_user.projects.find_by(id: params[:project_id])
      @current_project = Project.find_by(id: params[:id])
      session[:current_project_id] = @current_project.id if @current_project
      @issues = @project.issues
    else
      @issues = Issue.where(user_id: current_user.id)
      session[:current_project_id] = nil
    end
  end

  def search_email
    @project = Project.find(params[:project_id])
    @users = User.where('email LIKE ?', "%#{params[:search_email]}%")
    @search = true
    render 'edit'
  end

  def search
    @user = User.find(params[:user_id])
    search_results = @user.projects.where('project_name LIKE ?', "%#{params[:q]}%")
    first_project = search_results.first

    if first_project
      redirect_to project_overview_path(user_id: current_user.id, id: first_project.id)
    else
      flash[:alert] = 'No matching project found!'
      redirect_to request.referrer
    end
  end

  private

  def project_params
    params.require(:project).permit(:project_name, :project_description,
      :indentifier, :public, :user_id, :issue_tracking, :time_tracking,
      :project_news, :documents, :files, :wiki, :forums, :calendar, :gantt,
      assigned_to: []
    )
  end

  def update_assigned_projects(user_ids, project_id)
    user_ids.reject(&:empty?).each do |user_id|
      user = User.find(user_id)
      assigned_projects = user.assigned_projects || []
      assigned_projects << project_id unless assigned_projects.include?(project_id)
      user.update(assigned_projects: assigned_projects)
    end
  end

  def update_removed_user_projects(user, project_id)
    if user.assigned_projects.include?(project_id)
      user.assigned_projects.delete(project_id)
      user.save
    end
  end
end
