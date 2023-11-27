class ProjectsController < ApplicationController
  def index
    @projects = current_user.projects.all
  end

  def new
  end

  def show
    @id = params[:id]
  end

  def edit
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

  private

  def project_params
    params.require(:project).permit(:project_name, :project_description,
      :indentifier, :public, :user_id, :issue_tracking, :time_tracking, :news,
      :documents, :files, :wiki, :forums, :calendar, :gantt
    )
  end

end
