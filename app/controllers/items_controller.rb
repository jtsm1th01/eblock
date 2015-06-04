class ItemsController < ApplicationController
  before_action :app_setup_if_needed, only: :index
  before_action :create_admin
  before_action :authenticate_user!, except: [:index, :show]
  before_action :clear_search_if_requested

  def index
    if search_terms = (params[:search] || session[:search])
      @items = Item.search(search_terms, @current_auction).includes(:bids).paginate(page: params[:page], per_page: 20)
      session[:search] ||= params[:search] #preserves search
    else
      if @current_auction.nil?
        @items = Item.all
      else
        @items = @current_auction.items.where(approved: true).includes(:bids).paginate(page: params[:page], per_page: 20)
      end
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
    if @current_auction != nil && auction_upcoming?
      @item = Item.new
    else 
      redirect_to :back, alert: "Tnank you, but we are not accepting donations at this time."
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
      @item.approval_in_process = true
      if @item.update(item_params.merge approved: true)
        @item.approval_in_process = false
        redirect_to review_path, :notice => 'Item has been approved.'
      else
        @item.approval_in_process = false
        redirect_to review_path,
        :alert => 'Please complete all fields before approving items'
      end
    elsif params[:commit] == "Decline"
      @item.declined = true
      @item.save(validate: false)
      redirect_to review_path, :notice => 'Item has been declined.'
    elsif @item.update(item_params.merge approved: current_user.admin )
      redirect_to item_path(@item), :notice => 'Item has been updated.'
    else
      render 'edit'
    end
  end

  def destroy
    if auction_upcoming?
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
    unless @current_auction.nil?
      @items = @current_auction.items.where(approved: false, declined: false) \
                               .paginate(page: params[:page], per_page: 10) 
    else
      @items = []
    end
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

    def create_admin
      @sponsor = User.first
      if user_signed_in? && User.count == 1 && @sponsor.admin == false
        @sponsor.update(admin: true)
        flash[:notice] = "Welcome to the Charity Dashboard!"
        redirect_to dashboard_path
      end
    end
end
