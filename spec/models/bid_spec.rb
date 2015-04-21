describe Bid do

  before(:each) { @bid = Bid.new(user_id: 1, item_id: 1, amount: 100) }

  subject { @bid }

  it { should be_valid }

  describe "when user is blank" do
    before { @bid.user = nil }
    it { should_not be_valid }
  end

  describe "when item is blank" do
    before { @bid.item = nil }
    it { should_not be_valid }
  end

  describe "when amount is blank" do
    before { @bid.amount = '' }
    it { should_not be_valid }
  end

  describe "when amount is non-numeric" do
    before { @bid.amount = 'one hundred million' }
    it { should_not be_valid }
  end

  describe "when amount is 0" do
    before { @bid.amount = 0 }
    it { should_not be_valid }
  end

end