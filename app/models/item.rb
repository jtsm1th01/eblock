class Item < ActiveRecord::Base
  
   has_attached_file :photo,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
# validates :auction_id, presence: true
# validates :user_id, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :value, presence: true
  validates :value, numericality: {only_integer: true}

  belongs_to :auction
  belongs_to :user
  has_many :bids
  accepts_nested_attributes_for :bids
  
 

  
  
  def high_bid
    bids.maximum("amount")
  end

end
