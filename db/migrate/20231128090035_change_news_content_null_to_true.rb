class ChangeNewsContentNullToTrue < ActiveRecord::Migration[7.0]
  def change
    change_column :news, :news_content, :string, null: true
  end
end
