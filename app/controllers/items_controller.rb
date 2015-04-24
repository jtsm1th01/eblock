class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new(:auction_id => Auction.last.id)
  end

  def show
    @item = Item.find(params[:id])
    @bid_count = @item.bids.count
    @no_bids = @bid_count == 0 ? true : nil
    @min_bid = @no_bids ? 5 : @item.high_bid + 5
    @item.bids.build
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def update
    @item = Item.find(params[:id])
    flash_msg = params[:item][:bids_attributes] \
      ? "Your bid has been entered. Thanks for your support!" : "Item has been updated."
    if @item.update(item_params) 
      redirect_to item_path(@item), :notice => "#{flash_msg}"
    else
      render 'edit'
    end
  end

  private
    def item_params
      params.require(:item).permit(:name,
                                   :description,
                                   :value,
                                   :user_id,
                                   :auction_id,
                                    bids_attributes: [:id, :amount])
    end
end
