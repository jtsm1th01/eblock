class Item < ActiveRecord::Base
#  validates :auction_id, presence: true
#  validates :user_id, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :value, presence: true
  validates :value, numericality: {only_integer: true}

  belongs_to :auction
  belongs_to :user
  has_many :bids
  accepts_nested_attributes_for :bids
  has_many :photos

  def high_bid
    bids.maximum("amount")
  end

end
