class RenameNewsToProjectNews < ActiveRecord::Migration[7.0]
  def change
    rename_column :projects, :news, :project_news
  end
end
