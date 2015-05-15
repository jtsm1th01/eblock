class CharitiesController < ApplicationController
  
  def dashboard
    auction = Auction.last
    pledges = auction.items.map do |item|
      item.high_bid.try(:amount)
    end
    @pledge_total = pledges.compact!.sum
    @donor_count = auction.donors.uniq.length
    @bidder_count = auction.bidders.uniq.length
    @donation_count = auction.items.count
    items_sold = auction.items.map do |item|
      item unless item.bids.empty?
    end
    @items_sold_count = items_sold.compact.length
  end
  
  
end