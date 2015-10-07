class Run < ActiveRecord::Base
  belongs_to :user

  validates :ran_on, presence: true
  validates :distance, numericality: { greater_than_or_equal_to: 1 }
end
