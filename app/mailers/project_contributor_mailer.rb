class ProjectContributorMailer < ApplicationMailer

  def added_as_project_contributor(user, current_user, project)
    @user = user
    @current_user =  current_user
    @project = project
    mail(to: @user.email, subject: "Welcome to #{@project.project_name}")
  end

  def removed_from_project(user, current_user, project)
    @removed_user = user
    @current_user =  current_user
    @project = project
    mail(to: @removed_user.email,
      subject: "You have been removed from #{@project.project_name}")
  end
end
