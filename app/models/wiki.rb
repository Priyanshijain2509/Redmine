class Wiki < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_rich_text :wiki_text
end
