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
    @high_bid = @item.high_bid unless @bid_count == 0
    @min_bid = @high_bid ? @high_bid + 5 : 5
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
    if params[:item][:bids_attributes]
      flash_msg = 'Your bid has been entered. Thanks for your support!'
    else
      flash_msg = 'Item has been updated.'
    end
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
                                   :photo,
                                    bids_attributes: [:id, :amount])
    end
end
