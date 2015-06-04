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
  
  def show
    @auctions = Auction.all
    @pending_items = Item.where(approved: false)
  end
  
  def edit
    @charity = Charity.last
  end
  
  def update
    @charity = Charity.last
    if @charity.update(charity_params)
      flash[:notice] = "Your Charity's information has been updated!"
      redirect_to edit_charity_path(@charity)
    else
      render 'edit'
    end
  end
  
  private
  
  def charity_params
    params.require(:charity).permit(:name, :subhead, :email, :url)
  end  
end