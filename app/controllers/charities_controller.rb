class CharitiesController < ApplicationController
  before_action :require_admin
  
  def show
    @auctions = Auction.all
    @pending_items = Item.where(approved: false)
  end
  
end