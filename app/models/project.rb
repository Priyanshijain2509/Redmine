class Project < ApplicationRecord
  belongs_to :user
  has_one :project_wiki, class_name: 'Wiki', dependent: :destroy
  has_many :news, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :issues, dependent: :destroy
  has_rich_text :project_description

  validates :project_name, presence: true, length: { minimum: 3, maximum: 20 }
  validates :project_description, presence: true, length: { minimum: 3, maximum: 1000 }
  validates :indentifier, presence: true, length: { minimum: 3, maximum: 20 }
end
