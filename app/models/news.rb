class News < ApplicationRecord
	belongs_to :project
  has_many :comments, dependent: :destroy
  has_rich_text :news_content
end
