require 'cgi'

class AuctionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:wrapup]
  
  def new
    @charity = Charity.last
    @auction = @charity.auctions.build
  end
  
  def create
    @charity = Charity.last
    @auction = @charity.auctions.build(auction_params)
    if @auction.save
      schedule_wrapup
      redirect_to root_url, :notice => 'Your auction has been created!'
    else
      render 'new', :alert => "We're sorry but we couldn't create your auction \
                               at this time"
    end
  end

  def show
    @auction = Auction.find(params[:id])
    pledges = @auction.items.map { |item| item.high_bid.try(:amount) }
    @pledge_total = pledges.compact.sum
    @payments_received = @auction.winning_bids.where(paid: true).map { |wbid| wbid.bid.amount }.sum
    
    @donor_count = @auction.donors.uniq.length
    @bidder_count = @auction.bidders.uniq.length
    
    @donation_count = @auction.items.count
    
    items_sold = @auction.items.to_a.delete_if { |item| item.bids.empty? }
    @items_sold_count = items_sold.compact.length
    @items_unsold_count = @auction.items.count - @items_sold_count
    
    @bids_count = @auction.bids.count
  end

  def wrapup
    @current_auction.determine_winning_bids
    @current_auction.donors.each do |donor|
      UserMailer.email_donor_wrapup(donor).deliver
    end
    @current_auction.bidders.each do |bidder|
      UserMailer.email_bidder_wrapup(bidder).deliver
    end
    UserMailer.email_sponsor_wrapup.deliver
    render :nothing => true, status: :ok
  end
  
  private

    def schedule_wrapup
      date = @auction.finish.utc.iso8601
      url = CGI::escape(wrapup_url)
      uri = URI(ENV["TEMPORIZE_URL"])
      HTTParty.post("https://api.temporize.net/v1/events/#{date}/#{url}",
        :basic_auth => {:username => uri.user, :password => uri.password})
    end

    def auction_params
      params.require(:auction).permit(:name, :start, :finish)
    end
end