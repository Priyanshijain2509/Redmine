module ApplicationHelper
  def current_project
    if session[:current_project_id]
      @current_project = Project.find_by(id: session[:current_project_id])
    else
      @current_project = nil
    end
    @current_project
  end
end
