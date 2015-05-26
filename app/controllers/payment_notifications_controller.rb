class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => :confirm_payment

  def confirm_payment
    params.permit!
    if params[:payment_status] == "Completed"
      @user = User.find(params[:custom])
      donors_and_items = Hash.new([])
      @user.winning_bids.each do |wbid|
        donors_and_items[wbid.item.user] += [wbid.item]
        wbid.update(paid: true)
      end
      donors_and_items.each do |donor, items|
        UserMailer.email_donor_payment_notice(donor, items, @user).deliver
      end
    end
    render :nothing => true, status: :ok
  end
end