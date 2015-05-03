class AuctionsController < ApplicationController
  def new
    @charity = Charity.find(params[:charity_id])
    @auction = @charity.auctions.build
  end
  
  def create
    @charity = Charity.find(params[:charity_id])
    @auction = @charity.auctions.build(auction_params)
    if @auction.save
      redirect_to root_url, :notice => 'Your auction has been created!'
      schedule_wrapup
    else
      render 'new', :alert => "We're sorry but we could create your auction \
                               at this time"
    end
  end
  
  def wrapup
    user = User.find_by_fname("Forrest")
    UserMailer.email_bidder_wrapup(user).deliver
  end
  
  private

    def schedule_wrapup
      date = @auction.finish
      url = wrapup_url
      Temporize.post("/events/#{date}/#{url}")
    end

    def auction_params
      params.require(:auction).permit(:name, :start, :finish)
    end
end