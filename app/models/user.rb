class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  validates :fname, presence: true
  validates :lname, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sesitive: false }

  has_many :items, inverse_of: :user
  has_many :bids
  has_many :winning_bids, through: :bids
  has_many :watch_list_items, dependent: :destroy

  def to_s
    "#{fname} #{lname}"
  end

  # TODO skin charity name in paypal form
  def paypal_url(return_url) 
    values = { 
      :business => 'mr_travis_smith-facilitator@hotmail.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :no_shipping => 1,
      :no_note => 1,
      :notify_url => 'http://eblock-next.herokuapp.com/confirm_payment',
      :custom => id
      }

    winning_bids.each_with_index do |wbid, index|
      values.merge!({
        "item_name_#{index + 1}" => wbid.item.name,
        "amount_#{index + 1}" => wbid.bid.amount
        })
    end

    # For test transactions use this URL
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end 
end
