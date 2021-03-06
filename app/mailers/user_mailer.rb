class UserMailer < ActionMailer::Base 
  before_action :get_current_auction
  before_action :get_funds_raised, except: :email_bid_update
  default from: Charity.last.nil? ? 'from@example.com' : %("#{Charity.last.name}")
  
  def get_current_auction
    @current_auction = Auction.order(:finish).last
  end

  def email_donor_wrapup(user)
    email_setup(user)
  end
  
  def email_donor_payment_notice(user, items, bidder)
    @items = items
    @bidder = bidder
    email_setup(user)
  end

  def email_bidder_wrapup(user)
    
    winning_bids = user.winning_bids
    @current_wbids = []
    winning_bids.each do |wbid|
      if wbid.item.auction == @current_auction
        @current_wbids.push(wbid)
      end
    end
    email_setup(user)
  end 
  
  def email_sponsor_wrapup
    mail(to: User.first.email, subject: 'Charity Auction Donor/Bidder List')
  end
  
  def email_outbid_notice(item)
    @item = item
    @user = item.current_winner
    @url = root_url
    @charity = Charity.last
    email_with_name = %(@user <#{@user.email}>)
    mail(to: email_with_name, subject: "You've been outbid!")
  end
  
  private
  def email_setup(user)
    @user = user
    @url = "https://eblock-jtsm1th01.c9users.io"
    @charity = Charity.last
    email_with_name = %(#{@user.fname} #{@user.lname} <#{@user.email}>)
    mail(to: email_with_name, subject: 'Charity Auction Wrap-up')
  end
  
  def get_funds_raised
    @funds_raised = @current_auction.calculate_funds_raised
  end
end
