class EditIssue < ApplicationRecord
  belongs_to :issue
  has_rich_text :notes
end
