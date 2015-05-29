module ApplicationHelper

  def auction_upcoming?
    DateTime.current < @current_auction.start
  end

  def auction_in_progress?
    now = DateTime.current
    now > @current_auction.start && now < @current_auction.finish
  end

  def auction_ended?
    DateTime.current > @current_auction.finish
  end

  def countdown_explanation
    if auction_upcoming?
      'Auction Begins in:'
    elsif auction_in_progress?
      'Auction Ends in:'
    elsif auction_ended?
      'Auction Has Ended'
    end
  end

  def config_countdown
    deadline = auction_upcoming? ? @current_auction.start : @current_auction.finish
    deadline.to_f * 1000
  end
end
