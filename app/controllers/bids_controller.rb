class BidsController < ApplicationController
  
  def create
    @item = Item.find(params[:item_id])
    if require_login
      return
    else
      @bid = @item.bids.build(bid_params)
      @bid.user = current_user    
      if @bid.save
        flash_msg = 'Your bid has been entered. Thanks for your support!'
        redirect_to item_url(@item), :notice => "#{flash_msg}"
      else
        flash_msg = "We're sorry, but your bid could not be entered."
        flash.now.alert = flash_msg
        redirect_to item_url(@item), :alert => "#{flash_msg}"
      end
    end
  end
  
  private
    def require_login
      unless user_signed_in?
        session[:forward_url] = item_url(@item)
        redirect_to new_user_session_path, :notice => "Please sign in."
      end
    end

    def bid_params
      params.require(:bid).permit(:amount)
    end
end