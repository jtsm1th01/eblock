class WatchListItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    watch_list_items = WatchListItem.where(user: current_user)
    @items = watch_list_items.map { |watch_list_item| watch_list_item.item }
    
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
  
end
