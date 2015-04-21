class Auction < ActiveRecord::Base
  validates :start, presence: true
  validates :finish, presence: true
  validates :charity_id, presence: true

  belongs_to :charity
end
