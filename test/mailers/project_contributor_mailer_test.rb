require "test_helper"

class ProjectContributorMailerTest < ActionMailer::TestCase
  test "added_as_project_contributor" do
    mail = ProjectContributorMailer.added_as_project_contributor
    assert_equal "Added as project contributor", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "removed_from_project" do
    mail = ProjectContributorMailer.removed_from_project
    assert_equal "Removed from project", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
