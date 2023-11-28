class CreateNews < ActiveRecord::Migration[7.0]
  def change
    create_table :news do |t|
      t.string :news_title, null: false
      t.string :news_content, null: false
      t.string :news_added_by, null: false
      t.integer :project_id, null: false
      t.timestamps
    end
    add_foreign_key :news, :projects
  end
end
