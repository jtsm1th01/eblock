class Auction < ActiveRecord::Base
  
  validates :charity_id, presence: true
  validates :name, presence: true
  validates :start, presence: true
  validates :finish, presence: true

  belongs_to :charity
end
