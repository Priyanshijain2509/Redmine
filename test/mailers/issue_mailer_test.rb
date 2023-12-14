require "test_helper"

class IssueMailerTest < ActionMailer::TestCase
  test "issue_assigned" do
    mail = IssueMailer.issue_assigned
    assert_equal "Issue assigned", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "removed_from_issue" do
    mail = IssueMailer.removed_from_issue
    assert_equal "Removed from issue", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
