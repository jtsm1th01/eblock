class User < ActiveRecord::Base
  validates :fname, presence: true
  validates :lname, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sesitive: false }

  has_many :items
  has_many :bids

end
