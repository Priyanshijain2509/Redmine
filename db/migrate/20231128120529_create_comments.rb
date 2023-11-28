class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :comment_body
      t.string :comment_added_by
      t.integer :project_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
    add_foreign_key :comments, :projects
    add_foreign_key :comments, :users
  end
end
