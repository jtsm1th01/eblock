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

  def current_bid
    bids[-2].amount
  end

  def min_bid(no_bids_flag)
    no_bids_flag ? 5 : current_bid + 5
  end
end
