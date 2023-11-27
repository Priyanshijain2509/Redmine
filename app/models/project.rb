class Project < ApplicationRecord
  belongs_to :user
  has_many :wikis, dependent: :destroy
  has_rich_text :project_description
end
