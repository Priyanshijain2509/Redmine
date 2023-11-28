class AddNewsToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :news, null: false, foreign_key: true
  end
end
