class Wiki < ApplicationRecord
  belongs_to :project
  has_rich_text :wiki_text
end
