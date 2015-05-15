class Charity < ActiveRecord::Base

  validates :name, presence: true

  has_many :auctions, inverse_of: :charity

end
