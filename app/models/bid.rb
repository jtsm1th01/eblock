class Bid < ActiveRecord::Base
  
  validates :item, presence: true
  validates :user, presence: true
  validates :amount, numericality: { only_integer: true, greater_than: 0 }

  belongs_to :item
  belongs_to :user
  has_one :winning_bid
end
