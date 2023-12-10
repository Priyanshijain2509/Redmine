class ChangeAssigneeDataTypeInIssues < ActiveRecord::Migration[7.0]
  def up
    change_column :issues, :assignee, :string
  end
end
