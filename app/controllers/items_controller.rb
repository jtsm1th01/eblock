class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new(:auction_id => Auction.last.id)
  end

  def show
    @item = Item.find(params[:id])
    @bid_count = @item.bids.count
    @high_bid = @bid_count == 0 ? nil : @item.high_bid_amount
    @min_bid = @high_bid ? @item.min_bid(@high_bid) : @item.starting_bid
    @bid = @item.bids.build
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = current_user.items.build(item_params)
    @item.auction = Auction.last
    if @item.save
      redirect_to root_url, :notice => 'Thank you for your donation!'
    else
      render 'new', :alert => "We're sorry but we could not accept \
                               your donation at this time."
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item), :notice => 'Item has been updated.'
    else
      render 'edit'
    end
  end

  private

    def item_params
      params.require(:item).permit(:name,
                                   :description,
                                   :value,
                                   :photo,
                                   :starting_bid,
                                   :bid_increment)
    end
end
