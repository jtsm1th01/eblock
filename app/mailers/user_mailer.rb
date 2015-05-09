class UserMailer < ActionMailer::Base
  default from: %("#{Charity.last.name}" <#{Charity.last.email}>)
  before_action :get_funds_raised, except: :email_bid_update
  
  def email_donor_wrapup(user)
    email_setup(user)
  end

  def email_bidder_wrapup(user)
    email_setup(user)   
  end
  
  def email_sponsor_wrapup
    mail(to: 'travis.smith@mac.com', subject: 'Charity Auction Wrap-up')
  end
  
  def email_bid_update(high_bid)
    @high_bid = high_bid
    @user = @high_bid.user 
    @url = root_url
    @charity = Charity.first
    email_with_name = %(@user <#{@user.email}>)
    mail(to: email_with_name, subject: "You\'ve been outbid!")
  end
  
  private
  def email_setup(user)
    @user = user
    @url = root_url
    @charity = Charity.first
    email_with_name = %(@user <#{@user.email}>)
    mail(to: email_with_name, subject: 'Charity Auction Wrap-up')
  end
  
  def get_funds_raised
    @funds_raised = Auction.last.calculate_funds_raised
  end
end
