# Preview all emails at http://localhost:3000/rails/mailers/issue_mailer
class IssueMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/issue_mailer/issue_assigned
  def issue_assigned
    IssueMailer.issue_assigned
  end

  # Preview this email at http://localhost:3000/rails/mailers/issue_mailer/removed_from_issue
  def removed_from_issue
    IssueMailer.removed_from_issue
  end

end
