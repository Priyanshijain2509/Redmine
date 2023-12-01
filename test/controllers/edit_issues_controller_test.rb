require "test_helper"

class EditIssuesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get edit_issues_index_url
    assert_response :success
  end

  test "should get create" do
    get edit_issues_create_url
    assert_response :success
  end

  test "should get edit" do
    get edit_issues_edit_url
    assert_response :success
  end

  test "should get update" do
    get edit_issues_update_url
    assert_response :success
  end

  test "should get delete" do
    get edit_issues_delete_url
    assert_response :success
  end
end
