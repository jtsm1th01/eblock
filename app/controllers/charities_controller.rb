class CharitiesController < ApplicationController
  
  def show
    @auctions = Auction.all
    @pending_items = Item.where(approved: "false")
  end
  
end