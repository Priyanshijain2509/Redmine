class CreateWikis < ActiveRecord::Migration[7.0]
  def change
    create_table :wikis do |t|
      t.string :wiki_text
      t.integer :project_id, null: false
      t.integer :created_by, null: false
      t.integer :updated_by, null: false
      t.timestamps
    end
    add_foreign_key :wikis, :projects
    add_foreign_key :wikis, :users, column: :created_by
    add_foreign_key :wikis, :users, column: :updated_by
  end
end
