describe Item do

  before(:each) { @item = Item.new(auction_id: 1, user_id: 1, name: 'piano',
                                  description: 'old and broken', value: 2000) }

  subject { @item }

  it { should be_valid }

  describe "when auction is blank" do
    before { @item.auction = nil }
    it { should_not be_valid }
  end

  describe "when user is blank" do
    before { @item.user = nil }
    it { should_not be_valid }
  end

  describe "when name is blank" do
    before { @item.name = " " }
    it { should_not be_valid }
  end

  describe "when description is blank" do
    before { @item.description = " " }
    it { should_not be_valid }
  end

  describe "when value is blank" do
    before { @item.value = nil }
    it { should_not be_valid }
  end

end