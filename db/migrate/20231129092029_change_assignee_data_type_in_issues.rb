class ChangeAssigneeDataTypeInIssues < ActiveRecord::Migration[7.0]
  def down
    change_column :issues, :assignee, :string
  end
end
