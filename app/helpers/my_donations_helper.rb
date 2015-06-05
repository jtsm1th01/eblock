module MyDonationsHelper

  def approval(item)
    return "Approved" if item.approved == true
    return "Pending" if item.approved == false && item.declined == false
    return "Declined" if item.declined == true
  end

end