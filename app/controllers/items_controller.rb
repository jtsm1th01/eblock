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
    @high_bid = @item.high_bid.try(:amount)
    @min_bid = @item.next_bid_amount
    @bid = @item.bids.build
    if signed_in? && @item.watched?(current_user)
      @watch_list_item = WatchListItem. \
                         find_by(item: @item, user: current_user).id
    end
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
  
  def show_my_donations
    @donations = Item.where(user: current_user)
    render 'my_donations'
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