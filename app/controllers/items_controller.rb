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
    @bid_count == 0 ? @no_bids = true : nil
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
    if @item.update(item_params)
      redirect_to item_path(@item)
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
