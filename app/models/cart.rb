class Cart 

  def initialize(user)
    @user = user
  end

  def paypal_url(return_url) 
    values = { 
      :business => 'charity@auction.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
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
