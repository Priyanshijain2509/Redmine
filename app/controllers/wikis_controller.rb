class WikisController < ApplicationController
  before_action :set_project, only: %i[index edit update create]
  def index
    @wiki = @project.project_wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    if @wiki.save
      flash[:notice] = 'Wiki successfully created!'
      redirect_to request.referrer || root_url
    else
      flash[:alert] = 'Error creating the wiki.'
      render :new
    end
  end

  def edit
    @wiki = @project.project_wiki
  end


  def update
    @wiki = @project.project_wiki
    if @wiki.update(wiki_params)
      flash[:notice] = 'wiki updated'
      redirect_to user_project_wikis_path
    else
      debugger
      flash[:alert] = "Wiki couldn't be updated"
      render 'edit'
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:wiki_text, :project_id, :created_by, :updated_by)
  end

  def set_project
    @project = Project.find_by(id: params[:project_id])
  end
end
