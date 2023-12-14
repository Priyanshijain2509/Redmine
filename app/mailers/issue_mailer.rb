class IssueMailer < ApplicationMailer

  def issue_assigned(user, current_user, project, issue)
    @user = user
    @current_user =  current_user
    @project = project
    @issue = issue
    mail( to: @user.email, subject: "You have been assigned to #{@issue.subject} issue")
  end

  def removed_from_issue(user, current_user, project, issue)
    @user = user
    @current_user =  current_user
    @project = project
    @issue = issue
    mail( to: @user.email, subject: "You have been removed from #{@issue.subject} issue")
  end
end
