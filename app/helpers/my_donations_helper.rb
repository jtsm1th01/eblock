module MyDonationsHelper

  def approval(item)
    return "Approved" if item.approved == true
    return "Pending" if item.approved == false && item.declined == false
    return "Declined" if item.declined == true
  end
  
  def result(item)
    if auction_ended?
      return "Unsold" if item.bids.empty?
      item.winning_bid.paid ? "Paid" : "Payment Pending"
    end
  end
  
  def buyer_email(item)
    if item.winning_bid 
      if item.winning_bid.paid
        item.winning_bid.bid.user.email
      else
        "Will Notify"
      end
    end
  end

end