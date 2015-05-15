class Auction < ActiveRecord::Base
  require 'paypal-sdk-rest'
  include PayPal::SDK::REST
  
  validates :charity, presence: true
  validates :name, presence: true
  validates :start, presence: true
  validates :finish, presence: true

  has_many :items, inverse_of: :auction
  has_many :winning_bids, through: :items
  has_many :donors, through: :items, source: :user
  has_many :bids, through: :items
  has_many :bidders, through: :bids, source: :user
  belongs_to :charity, inverse_of: :auctions
  
  def determine_winning_bids
    items.each do |item|
      unless item.bids.empty?
        WinningBid.create(bid: item.high_bid, item: item)
      end
    end
  end  

  def calculate_funds_raised
    winning_bids.map { |bid| bid.amount }.sum
  end
  
  def invoice_buyers
    @api = PayPal::SDK::REST.set_config(
      :ssl_options => {}, # Set ssl options
      :mode => :sandbox,  # Set :sandbox or :live
      :client_id     => "ASS7bvXOZfNo0IErQjO9hXFCz3lIMS2ufx6OTkVDzPlkTK5w-VoDbN4GlWm2cweJEgZLzhCspDMjCvr-",
      :client_secret => "EM45p6FAaE6QoHftofXY7OnX0dIGuAWXHBvskOrFxCblbPZ7bx5kexbkO8c6zdCPi_36SuXT7_sThGRM" )
    @api.token
    
  end

end
