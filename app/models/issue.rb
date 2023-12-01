class Issue < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :edit_issues, dependent: :destroy
  has_rich_text :issue_description
  has_many_attached :files, dependent: :destroy
end
