class BidsController < ApplicationController
  before_action :set_item
  before_action :require_login

  def create
    @high_bid = @item.bids.find_by_amount(@item.high_bid_amount)
    watch_list_item = WatchListItem.find_by(user_id: @high_bid.user, item_id: @item.id)
    if @item.high_bid_amount != 0 && !watch_list_item.nil? && 
      watch_list_item.wants_email
      UserMailer.email_bid_update(@item).deliver
    end
    @bid = @item.bids.build(bid_params)
    @bid.user = current_user
    if @bid.save
      auto_add_to_watch_list(@item)
      redirect_to item_url(@item),
      :notice => 'Your bid has been entered. Thanks for your support!'
    else
      redirect_to item_url(@item),
      :alert => "We're sorry, but your bid could not be entered."
    end
  end
  
  private

    def auto_add_to_watch_list(item)
      unless item.watched?(current_user)
        current_user.watch_list_items.create(item_id: item.id)
      end
    end

    def set_item
      @item = Item.find(params[:item_id])
    end

    def require_login
      unless user_signed_in?
        session[:forward_url] = item_url(@item)
                 redirect_to new_user_session_path,
                :alert => 'Please sign in or sign up before continuing.'
      end
    end

    def bid_params
      params.require(:bid).permit(:amount)
    end
end