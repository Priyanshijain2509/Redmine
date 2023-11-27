class AddandRemoveColumnsfromProjects < ActiveRecord::Migration[7.0]
  def change
    remove_column :projects, :status, :string
    add_column :projects, :public, :boolean, default: false
    add_column :projects, :issue_tracking, :boolean, default: false
    add_column :projects, :time_tracking, :boolean, default: false
    add_column :projects, :news, :boolean, default: false
    add_column :projects, :documents, :boolean, default: false
    add_column :projects, :files, :boolean, default: false
    add_column :projects, :wiki, :boolean, default: false
    add_column :projects, :forums, :boolean, default: false
    add_column :projects, :calendar, :boolean, default: false
    add_column :projects, :gantt, :boolean, default: false
  end
end
