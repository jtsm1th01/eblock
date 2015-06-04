class Charity < ActiveRecord::Base

  validates :name, :subhead, :url, :bg_color, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sesitive: false }

  validates :name, presence: true
  has_many :auctions, inverse_of: :charity
  has_attached_file :logo, 
                    :styles => { :medium => "300x300>", :thumb => "200x200>" }, 
                    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

end
