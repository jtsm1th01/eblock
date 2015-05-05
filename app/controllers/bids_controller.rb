class BidsController < ApplicationController
  before_action :set_item
  before_action :require_login

  def create
    @bid = @item.bids.build(bid_params)
    @bid.user = current_user
    if @bid.save
      redirect_to item_url(@item),
      :notice => 'Your bid has been entered. Thanks for your support!'
    else
      redirect_to item_url(@item),
      :alert => "We're sorry, but your bid could not be entered."
    end
  end
  
  private

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