describe Auction do
  
  it "should be valid" do
    auction = Auction.new(name: 'Spring Fundraiser', charity_id: 1, start: Time.now, finish: Time.now + 86400)
    expect(auction).to be_valid
  end
  
end