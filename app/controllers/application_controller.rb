class ApplicationController < ActionController::Base
  include ApplicationHelper
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :clear_current_project, unless: :project_related_controller?

  private

  def clear_current_project
    session[:current_project_id] = nil
  end

  def project_related_controller?
    project_controllers = %w[projects issues wikis news]
    project_controllers.any? { |controller| params[:controller].start_with?(controller) }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :first_name, :last_name, :language, :nick_name])

    devise_parameter_sanitizer.permit(:account_update, keys: [
      :first_name, :last_name, :language, :nick_name])
  end
end
