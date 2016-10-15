class Item < ActiveRecord::Base

  attr_accessor :approval_in_process
  before_save   :downcase_item_name_for_name_down_column
  before_update :downcase_item_name_for_name_down_column

  validates :auction, :user, :name, :description, presence: true
  validates :value, numericality: {only_integer: true, greater_than: 0, :message => " cannot be blank" }
  validates :starting_bid, :bid_increment,
  numericality: {only_integer: true, greater_than: 0}, if: "approval_in_process"

  belongs_to :auction, inverse_of: :items
  belongs_to :user, inverse_of: :items
  has_many :bids, dependent: :destroy
  has_one :winning_bid
  has_many :watch_list_items, dependent: :destroy
  has_attached_file :photo,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  def to_s
    name.titleize
  end

  def high_bid
    bids.max
  end
  
  def sort_by_current_bid
    high_bid.try(:amount) || 0
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
  
  def Item.search(search_terms, auction)
    keyword = Rails.env == 'production' ? 'ILIKE' : 'LIKE'
    search_terms = search_terms.split
    conditions = [ (["name #{keyword} ?"] * search_terms.count).join(' OR ') +
                          ' AND auction_id = ? ' + 'AND approved = ?' ]

    query_values = search_terms.map {|term| "%#{term}%"} << "#{auction.id}" << true

    Item.where(conditions + query_values)
  end

  def downcase_item_name_for_name_down_column
    self.name_down = self.name.downcase
  end
end
