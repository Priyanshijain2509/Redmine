class WikisController < ApplicationController
  before_action :set_project, only: %i[index edit update]
  def index
    @wiki = @project.wikis.first
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
    @wiki = @project.wikis.first
  end


  def update
    @wiki = @project.wikis.first
    if @wiki.update(wiki_params)
      flash[:notice] = 'wiki updated'
      redirect_to user_project_wikis_path
    else
      flash[:alert] = "Wiki couldn't be updated"
      render 'edit'
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:wiki_text, :project_id, :created_by, :updated_by)
  end

  def set_project
    @project = Project.find_by(params[:project_id])
  end
end
