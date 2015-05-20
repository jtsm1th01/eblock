class Item < ActiveRecord::Base
  
  has_attached_file :photo,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  validates :auction, presence: true
  validates :user, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :value, :starting_bid, :bid_increment,
             numericality: {only_integer: true, greater_than: 0}
  belongs_to :auction, inverse_of: :items
  belongs_to :user, inverse_of: :items
  has_many :bids
  has_one :winning_bid
  has_many :watch_list_items, dependent: :destroy
  
  def high_bid
    bids.max
  end
  
  def sort_by_current_bid
    bids.max.try(:amount) || 0
  end
  
  def sort_by_number_of_bids
    bids.count
  end
    
  def current_winner
    high_bid.try(:user)
  end

  def next_bid_amount
    bids.empty? ? starting_bid : high_bid.amount + bid_increment
  end
  
  def watched?(user)
    user.watch_list_items.pluck(:item_id).include?(id)
  end
end
