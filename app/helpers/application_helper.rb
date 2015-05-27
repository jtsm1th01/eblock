module ApplicationHelper
  def countdown_explanation
    if @auction_upcoming
      'Auction Begins in:'
    elsif @auction_in_progress
      'Auction Ends in:'
    elsif @auction_over
      'Auction Has Ended'
    end
  end

  def config_countdown
    deadline = @auction_upcoming ? @auction.start : @auction.finish
    deadline.to_f * 1000
  end
end
