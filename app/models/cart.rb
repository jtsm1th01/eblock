class Cart 

  def initialize(user)
    @user = user
  end

  # must be valid paypal test acct, so business not skinnable for demo purposes
  def paypal_url(return_url) 
    values = { 
      :business => 'mr_travis_smith-facilitator@hotmail.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :no_shipping => 1,
      :no_note => 1,
      :notify_url => 'http://eblock-next.herokuapp.com/confirm_payment',
      :custom => @user.id
      }

    @user.winning_bids.each_with_index do |wbid, index|
      values.merge!({
        "item_name_#{index + 1}" => wbid.item.name,
        "amount_#{index + 1}" => wbid.bid.amount
        })
    end

    # For test transactions use this URL
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end

end
