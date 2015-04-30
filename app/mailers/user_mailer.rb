class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def end_of_auction_bidder(user)
    @user = user
    @url = 'https://example.com/login'
    email_with_name = %("#{@user.fname} + #{@user.lname}" <#{@user.email}>)
    mail(to: email_with_name, subject: 'Charity Auction Wrap-up')
  end
  
  def end_of_auction_donor(user)
    @user = user
    @url = 'https://example.com/login'
    email_with_name = %("#{@user.fname} + #{@user.lname}" <#{@user.email}>)
    mail(to: email_with_name, subject: 'Charity Auction Wrap-up')
  end
end
