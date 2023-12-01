class News < ApplicationRecord
	belongs_to :project
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_rich_text :news_content
end
