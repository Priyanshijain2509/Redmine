class Comment < ApplicationRecord
	belongs_to :news
  belongs_to :user

  validates :comment_body, presence: true, length: { minimum: 3, maximum: 20 }
  validates :comment_added_by, presence: true
  validates :project_id, presence: true
  validates :user_id, presence: true
end
