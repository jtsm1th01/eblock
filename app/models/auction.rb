class Auction < ActiveRecord::Base
  
  validates :charity, presence: true
  validates :name, presence: true
  validates :start, presence: true
  validates :finish, presence: true

  has_many :items, inverse_of: :auction
  belongs_to :charity, inverse_of: :auctions
end
