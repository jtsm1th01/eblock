class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index

    @auction = Auction.find_by_name(params[:name]) || get_current_auction

    search_params = params[:search] || session[:search]
    @items = search_params ? Item.search(search_params).includes(:bids) : Item.all.includes(:bids)
    if params[:name_sort]
      @items = @items.order("name #{params[:name_sort]}")
    elsif params[:current_bid_sort]
      @items = @items.order("bids.amount #{params[:current_bid_sort]}")
    elsif params[:bid_count_sort]
      @items = @items.sort_by(&:sort_by_number_of_bids)
      params[:bid_count_sort] == "DESC" ? @items.reverse! : @items
    end
session[:search] ||= params[:search]
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
    if params[:commit] == "Approve"
      @item.update(approved: true)
    end
    if @item.update(item_params) && params[:commit] == "Approve" 
      redirect_to review_path, :notice => 'Item has been approved.'
    elsif @item.update(item_params) 
      redirect_to item_path(@item), :notice => 'Item has been updated.'
    else
      render 'edit'
    end
  end

#def approve
#  item = Item.find(params[:id])
#  item.edit(approved: true)
#  unless item.starting_bid.nil?
#    item.save(item_params)
#  
#  if @item.update(item_params)
#    redirect_to item_path(@item), :notice => 'Item has been updated.'
#  else
#    render 'edit'
#  end
#end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to my_donations_path, notice: 'Item removed from the auction.' 
  end
  
  def show_my_donations
    @donations = Item.where(user: current_user)
    render 'my_donations'
  end

  def review
    @items = Item.where(approved: false) 
  end

  private

    def item_params
      params.require(:item).permit(:name,
                                   :description,
                                   :value,
                                   :photo,
                                   :starting_bid,
                                   :bid_increment,
                                   :approved)
    end
end
