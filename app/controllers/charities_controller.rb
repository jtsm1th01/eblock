class CharitiesController < ApplicationController
  def show
    @auctions = Auction.all
  end
  
end