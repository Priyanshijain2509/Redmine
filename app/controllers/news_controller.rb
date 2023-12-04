class NewsController < ApplicationController
  before_action :set_project, only: %i[index edit update new show]

  def new
    @project = Project.find_by(params[:project_id])
  end

  def index
    @news = @project.news
  end

  def edit
    @news = @project.news.find_by(id: params[:id])
  end

  def show
    @news = News.find_by(id: params[:id])
  end

  def create
    @news = News.new(news_params)
    if @news.save
      flash[:notice] = 'News successfully created!'
      redirect_to user_project_news_index_path
    else
      flash[:alert] = 'Error creating the News.'
      render :new
    end
  end

  def update
    @news = @project.news.find_by(id: params[:id])
    if @news.update(news_params)
      flash[:notice] = 'News updated'
      redirect_to user_project_news_index_path
    else
      flash[:alert] = "News couldn't be updated"
      render 'edit'
    end
  end

  private

  def news_params
    params.require(:news).permit(:news_title, :news_content,
                                 :news_added_by, :project_id)
  end

  def set_project
    @project = Project.find_by(params[:project_id])
  end
end
