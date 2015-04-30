class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  before_action :email_setup
  
  def email_donor_wrapup(user)
  end
  
  def email_bidder_wrapup(user)
  end
  
  private
    def email_setup
      @user = user
      @url = root_url
      email_with_name = %(@user <#{@user.email}>)
      mail(to: email_with_name, subject: 'Charity Auction Wrap-up')
    end
end
