class FoodJournal < ActiveRecord::Base
  belongs_to :user

  validates :food, presence: true
  validates :qty, presence: true
end
