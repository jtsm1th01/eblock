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
  
  def high_bid
    bids.maximum("amount")
  end

  def min_bid(going_bid)
    bids.count == 0 ? going_bid : (going_bid + bid_increment)
  end

end
