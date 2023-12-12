class AddColumnAssignedProjectsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :assigned_projects, :string
  end
end
