class EditIssue < ApplicationRecord
  belongs_to :issue

  has_rich_text :notes

  validates :updated_by, presence: true
  validates :project_id, presence: true
  validates :issue_id, presence: true
end
