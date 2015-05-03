require 'cgi'

class AuctionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:wrapup]
  
  def new
    @charity = Charity.find(params[:charity_id])
    @auction = @charity.auctions.build
  end
  
  def create
    @charity = Charity.find(params[:charity_id])
    @auction = @charity.auctions.build(auction_params)
    if @auction.save
      schedule_wrapup
      redirect_to root_url, :notice => 'Your auction has been created!'
    else
      render 'new', :alert => "We're sorry but we couldn't create your auction \
                               at this time"
    end
  end
  
  def wrapup
    User.all.each do |user|
      UserMailer.email_bidder_wrapup(user).deliver
      UserMailer.email_donor_wrapup(user).deliver unless bids.items.empty?
    end
    render json: nil, status: :ok
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