class Auction < ActiveRecord::Base
  
  validates :charity, presence: true
  validates :name, presence: true
  validates :start, presence: true
  validates :finish, presence: true

  has_many :items, inverse_of: :auction
  belongs_to :charity, inverse_of: :auctions
  
  def determine_winning_bids
    items.each do |item|
      if item.bids.any?
        WinningBid.create(bid_id:item.winning_bid.id,item_id:item.id)
      end
    end
  end  

end
