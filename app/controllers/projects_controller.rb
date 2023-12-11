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

  def edit; end

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
      :project_news, :documents, :files, :wiki, :forums, :calendar, :gantt
    )
  end
end
