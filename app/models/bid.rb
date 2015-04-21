class Bid < ActiveRecord::Base
  validates :item_id, :user_id, presence: true
  validates :amount, numericality: { only_integer: true, greater_than: 0 }

  belongs_to :item
  belongs_to :user
end
