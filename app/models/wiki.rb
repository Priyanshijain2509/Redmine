class Wiki < ApplicationRecord
  belongs_to :project
  belongs_to :user, foreign_key: 'created_by', class_name: 'User'
  has_rich_text :wiki_text
end
