class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new(:auction_id => Auction.last.id)
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_url
    else
      render 'new'
    end
  end
    
  
  def show
    @item = Item.find(params[:id])
  end
    
    private
    
    def item_params
      params.require(:item).permit(:name, :description, :value, :user_id, :auction_id)
    end
end
