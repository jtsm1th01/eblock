class BidsController < ApplicationController
  before_action :set_item
  before_action :require_login

  def create
    if accepting_bids?
      outbid_email = prepare_outbid_notice_if_requested
      @bid = @item.bids.build(bid_params)
      @bid.user = current_user
      if @bid.save
        outbid_email.deliver unless outbid_email.nil?
        auto_add_to_watch_list(@item)
        redirect_to item_url(@item),
        :notice => 'Your bid has been entered. Thanks for your support!'
      else
        redirect_to item_url(@item),
        :alert => "We're sorry, but your bid could not be entered."
      end
    else
      redirect_to item_url(@item),
      :alert => "We're sorry, but this auction has ended."
    end
  end
  
  private

    def prepare_outbid_notice_if_requested
      if WatchListItem.where(item: @item,
                             user: @item.current_winner,
                             wants_email: true).exists?
        UserMailer.email_outbid_notice(@item)
      end
    end

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

    def accepting_bids?
      Time.now < Auction.last.finish
    end

    def bid_params
      params.require(:bid).permit(:amount)
    end
end