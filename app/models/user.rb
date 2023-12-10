class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :confirmable

  has_many :projects, dependent: :destroy
  has_many :wikis, foreign_key: 'created_by', class_name: 'Wiki'

  # validations
  validates :first_name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 20 }
  validates :nick_name, presence: true, length: { minimum: 3, maximum: 20 }
  validates :language, presence: true
end
