class User < ActiveRecord::Base

  has_many :food_journals

  validates_uniqueness_of :handle
  validates_length_of :handle, :minimum => 3
  validates :handle, presence: true
  validates :password, length: {
    minimum:3,
    maximum:15,
    too_short: "Please make a password that is greater than 3 characters.",
    too_short: "Please make a password that is shorter."
  }
  validates :age, presence: true
  validates :weight , presence: true
  validates :target, presence: true
  validates :height, presence: true



end
