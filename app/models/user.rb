class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  validates :fname, presence: true
  validates :lname, presence: true
  has_many :items, inverse_of: :user
  has_many :bids
  has_many :winning_bids, through: :bids
  has_many :watch_list_items, dependent: :destroy

  def to_s
    "#{fname} #{lname}"
  end

  # must be valid paypal test acct, so business not skinnable for demo purposes
  def paypal_url(return_url, current_wbids) 
    values = { 
      :business => 'mr_travis_smith-facilitator@hotmail.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :no_shipping => 1,
      :no_note => 1,
      :notify_url => 'http://auctionblock.herokuapp.com/confirm_payment',
      :custom => id
      }

    current_wbids.each_with_index do |wbid, index|
      values.merge!({
        "item_name_#{index + 1}" => wbid.item.name,
        "amount_#{index + 1}" => wbid.bid.amount
        })
    end

    # For test transactions use this URL
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end 
end
