# Preview all emails at http://localhost:3000/rails/mailers/project_contributor_mailer
class ProjectContributorMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/project_contributor_mailer/added_as_project_contributor
  def added_as_project_contributor
    ProjectContributorMailer.added_as_project_contributor
  end

  # Preview this email at http://localhost:3000/rails/mailers/project_contributor_mailer/removed_from_project
  def removed_from_project
    ProjectContributorMailer.removed_from_project
  end

end
