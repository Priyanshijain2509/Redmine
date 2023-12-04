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
  end

  def activity
    @project = Project.find_by(id: params[:id])
  end

  def roadmap
    @project = Project.find_by(id: params[:id])
  end

  def overview
    @project = Project.find_by(id: params[:id])
  end

  private

  def project_params
    params.require(:project).permit(:project_name, :project_description,
      :indentifier, :public, :user_id, :issue_tracking, :time_tracking,
      :project_news, :documents, :files, :wiki, :forums, :calendar, :gantt
    )
  end

end
