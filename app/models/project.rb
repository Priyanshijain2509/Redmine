class Project < ApplicationRecord
  belongs_to :user
  has_many :wikis, dependent: :destroy
  has_many :news, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_rich_text :project_description
end
