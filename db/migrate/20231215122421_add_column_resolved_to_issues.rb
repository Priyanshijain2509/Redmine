class AddColumnResolvedToIssues < ActiveRecord::Migration[7.0]
  def change
    add_column :issues, :issue_resolved, :boolean
  end
end
