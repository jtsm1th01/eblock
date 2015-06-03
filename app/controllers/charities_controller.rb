class CharitiesController < ApplicationController
  before_action :require_admin, except: :new
  
  def new
    if Charity.any?
      flash[:alert] = "Charity setup already completed"
      #redirect_to and return root_url
    else    
      @charity = Charity.new
      render :layout => false
      
    end
  end
  
  def show
    @auctions = Auction.all
    @pending_items = Item.where(approved: false)
  end
  
end