class Cart 

  def initialize(user)
    @user = user
  end

  # TODO skin charity name in paypal form
  def paypal_url(return_url) 
    values = { 
      :business => 'auction@charity.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :no_shipping => 1,
      :notify_url => 'http://bigruby2-161620.usw1.nitrousbox.com/ipn_test'
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
