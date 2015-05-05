class WatchListItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = WatchListItem.where(user: current_user)
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
