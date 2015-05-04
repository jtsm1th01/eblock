class WinningBid < ActiveRecord::Base
  belongs_to :bid
  belongs_to :item
  
end
