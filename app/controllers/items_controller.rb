class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :update]

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
    @item = current_user.items.build(item_params)
    @item.auction = Auction.last
    if @item.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def update
    @item = Item.find(params[:id])
    if params[:item][:bids_attributes]
      require_login
      flash_msg = 'Your bid has been entered. Thanks for your support!'
      return
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

  def require_login
    unless user_signed_in?
      session[:forward_url] = request.fullpath
      redirect_to new_user_session_path, :notice => "Please sign in."
    end
  end
  
  def item_params
      params.require(:item).permit(:name,
                                   :description,
                                   :value,
                                   :photo,
                                    bids_attributes: [:id, :amount])
    end
end
