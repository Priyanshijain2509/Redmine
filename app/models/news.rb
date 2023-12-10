class News < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy
  has_rich_text :news_content
  validates :news_title, presence: true, length: { minimum: 3, maximum: 20 }
  validates :news_added_by, presence: true, length: { minimum: 3, maximum: 20 }
  validates :project_id, presence: true
end
