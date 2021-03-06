class WatchListItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :user
  
  validates :item, presence: true
  validates :user, presence: true
  
  def to_s
    item.name
  end

end
