describe Auction do
  
before(:each) { @auction = Auction.new(name: 'Spring Fundraiser', charity_id: 1, start: Time.now, finish: Time.now + 86400) }
  
  subject { @auction }
  
  it { should be_valid }
  
  describe "when name is blank" do
    before { @auction.name = " " }
    it { should_not be_valid }
  end
  
  describe "when charity is blank" do
    before { @auction.charity = nil }
    it { should_not be_valid }
  end
  
  describe "when start is blank" do
    before { @auction.start = nil }
    it { should_not be_valid }
  end
  
  describe "when finish is blank" do
    before { @auction.finish = nil }
    it { should_not be_valid }
  end

end