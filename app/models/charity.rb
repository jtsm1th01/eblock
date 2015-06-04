class Charity < ActiveRecord::Base

  validates :name, presence: true
  has_many :auctions, inverse_of: :charity
  has_attached_file :logo, 
                    :styles => { :medium => "300x300>", :thumb => "200x200>" }, 
                    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

end
