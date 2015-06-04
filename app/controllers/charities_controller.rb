class CharitiesController < ApplicationController
  before_action :require_admin, only: :show
  
  def new
    if Charity.any?
      flash[:alert] = "Charity setup already completed"
      redirect_to and return root_url
    else    
      @charity = Charity.new
      render :layout => false
    end
  end
  
  def create
    @charity = Charity.new(charity_params)
    if @charity.save
      redirect_to new_user_registration_path
    else
      render 'new'
    end
  end
  
  # Charities#show corresponds to the sponsor dashboard.
  def show
    @auctions = Auction.all
    unless @current_auction.nil?
      @pending_items_count = @current_auction.items.where(approved: false).count
    else
      @pending_items_count = 0
    end
  end
  
  private
  
  def charity_params
    params.require(:charity).permit(:name, :subhead, :email, :url)
  end
  
end