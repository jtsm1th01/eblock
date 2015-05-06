class WatchListItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    watch_list_items = WatchListItem.where(user: current_user)
    items = watch_list_items.map { |watch_list_item| watch_list_item.item }
    @watch_list = Hash.new
    items.each do |item|
      user_bid = item.bids.where(user: current_user).maximum("amount") || 0
      @watch_list[item] = {
             :status => status_msg(item),
             :user_bid => user_bid,
             :watch_list_item => watch_list_items.find_by(item_id: item.id).id }
    end   
  end

  def create
    item = Item.find(params[:item_id])
    watch_list_item = WatchListItem.new(item: item, user: current_user)
    if watch_list_item.save
      flash[:notice] = "#{item} added to your watch list."
    else
      flash[:alert] = "#{item} could not be added to your watch list."
    end
    redirect_to :back
  end

  def destroy
    watch_list_item = WatchListItem.find(params[:id])
    item = watch_list_item.item
    watch_list_item.destroy
    redirect_to :back, :notice => "#{item} removed from your watch list."
  end

  private
  
  def status_msg(item)
     if item.bids.where(user: current_user).empty?
        "You have not bid."
      elsif item.winning_bid.user == current_user
        "You are winning this item."
      else
        "You have been outbid!"
      end
  end
  
end
