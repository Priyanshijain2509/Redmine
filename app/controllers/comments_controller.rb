class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = 'Comment created!'
      redirect_to user_project_news_path(
        user_id: current_user.id, project_id: params[:project_id],
        id: params[:news_id])
    else
      flash[:error] = "Comment can't be created!"
      render 'new'
    end
  end

  def new
    @news = News.find_by(id: params[:news_id])
  end

  private

  def comment_params
    params.require(:comment).permit(
      :comment_body, :comment_added_by, :project_id, :user_id, :news_id)
  end
end
