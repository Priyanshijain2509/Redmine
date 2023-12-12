class AddAssignedToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :assigned_to, :string
  end
end
