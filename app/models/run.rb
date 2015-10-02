class Run < ActiveRecord::Base
  belongs_to :user

  validates :ran_on, presence: true
  validates :distance, numericality: true
end
