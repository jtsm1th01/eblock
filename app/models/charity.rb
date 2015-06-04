class Charity < ActiveRecord::Base

  validates :name, :subhead, :url, :bg_color, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sesitive: false }

  has_many :auctions, inverse_of: :charity

end
