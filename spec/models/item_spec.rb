describe Item do
  
  it "should be valid" do
    item = Item.new(auction_id: 1, user_id: 1, name: 'piano', description: 'old and broken', value: 2000)
    expect(item).to be_valid
  end
  
end