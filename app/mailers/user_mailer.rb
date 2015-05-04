class UserMailer < ActionMailer::Base
  default from: %("#{Charity.last.name}" <#{Charity.last.email}>)
  
  def email_donor_wrapup(user)
    email_setup(user)
  end

  def email_bidder_wrapup(user)
    email_setup(user)
  end
  
  private
  def email_setup(user)
    @user = user
    @url = root_url
    @funds_raised = Auction.last.calculate_funds_raised
    email_with_name = %(@user <#{@user.email}>)
    mail(to: email_with_name, subject: 'Charity Auction Wrap-up')
  end
end
