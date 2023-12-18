class CreateIssues < ActiveRecord::Migration[7.0]
  def change
    create_table :issues do |t|
      t.string :tracker, null: false
      t.string :subject, null: false
      t.string :issue_description
      t.string :issue_status
      t.string :category
      t.datetime :start_date
      t.datetime :end_date
      t.integer :estimated_time
      t.integer :assignee, array: true, default: []
      t.integer :project_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
    add_foreign_key :issues, :projects
    add_foreign_key :issues, :users
    add_index :issues, :assignee, using: 'gin'
  end
end
