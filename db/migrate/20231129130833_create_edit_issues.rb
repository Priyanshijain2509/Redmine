class CreateEditIssues < ActiveRecord::Migration[7.0]
  def change
    create_table :edit_issues do |t|
      t.string :notes
      t.string :updated_by
      t.references :issue, null: false, foreign_key: true
      t.integer :project_id, null: false
      t.timestamps
    end
    add_foreign_key :edit_issues, :projects
  end
end
