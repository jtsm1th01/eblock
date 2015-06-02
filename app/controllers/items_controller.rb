class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :clear_search_if_requested

  def index
    if search_terms = (params[:search] || session[:search])
      @items = Item.search(search_terms, @current_auction).includes(:bids)
      session[:search] ||= params[:search] #preserves search
    else
      @items = @current_auction.items.where(approved: true).includes(:bids)
    end
    # TODO: Take Julian's feedback into account for sorting methods.
    if params[:name_sort]
      @items = @items.order("name #{params[:name_sort]}")
    elsif params[:current_bid_sort]
      @items = @items.order("bids.amount #{params[:current_bid_sort]}")
    elsif params[:bid_count_sort]
      @items = @items.sort_by(&:sort_by_number_of_bids)
      params[:bid_count_sort] == "DESC" ? @items.reverse! : @items
    end
  end

  def new
    if auction_upcoming?
      @item = Item.new
    else 
      redirect_to :back, alert: "We're sorry but the donation period has ended."
    end
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
    if(auction_upcoming? || current_user.admin?)
      @item = Item.find(params[:id])
    else
      redirect_to :back, alert: "Changes not allowed once auction begins."
    end
  end

  def create
    @item = current_user.items.build(item_params)
    @item.auction = @current_auction
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
      @item.update(item_params.merge approved: true)
      redirect_to review_path, :notice => 'Item has been approved.'
    elsif @item.update(item_params.merge approved: false)
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
    if(auction_upcoming? || current_user.admin?)
      @item = Item.find(params[:id])
      @item.destroy
      redirect_to my_donations_path, notice: 'Item removed from the auction.' 
    else
      redirect_to :back, alert: "Changes not allowed once auction begins."
    end
  end
  
  def show_my_donations
    @donations = Item.where(user: current_user).includes(:bids)
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

    def clear_search_if_requested
      session[:search] = nil if params[:clear_search]
    end
end
