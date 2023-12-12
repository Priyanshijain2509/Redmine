class Issue < ApplicationRecord
  belongs_to :project
  belongs_to :user

  has_many :edit_issues
  has_many_attached :files, dependent: :destroy
  has_rich_text :issue_description

  validates :subject, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :date_cannot_be_in_the_past
  validate :end_date_cannot_be_less_than_start_date

  serialize :assignee, Array

  private

  def date_cannot_be_in_the_past
    errors.add(:start_date, "can't be in the past") if start_date && start_date < Date.today
    errors.add(:end_date, "can't be in the past") if end_date && end_date < Date.today
  end

  def end_date_cannot_be_less_than_start_date
    if start_date && end_date && end_date < start_date
      errors.add(:end_date, "can't be less than the start date")
    end
  end
end
