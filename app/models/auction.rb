class Auction < ActiveRecord::Base
  
  validates :charity, presence: true
  validates :name, presence: true
  validates :start, presence: true
  validates :finish, presence: true

  has_many :items, inverse_of: :auction, dependent: :destroy
  has_many :winning_bids, through: :items
  has_many :donors, through: :items, source: :user
  has_many :bids, through: :items
  has_many :bidders, through: :bids, source: :user
  belongs_to :charity, inverse_of: :auctions
  
  def to_s
    name
  end

  def duration
    format_date = Proc.new do |date| 
      date.strftime("%B #{date.day.ordinalize} at %I:%M %p")
    end
    format_date.call(start) + ' - ' + format_date.call(finish) + " (" + start.strftime("%Z") + ")"
  end

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

end
