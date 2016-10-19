class WinningBid < ActiveRecord::Base
  belongs_to :bid
  belongs_to :item
  has_one :auction, through: :item
  
  def amount
    bid.amount
  end

end
