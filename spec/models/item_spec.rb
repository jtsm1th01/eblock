describe Item do

  before(:each) { @item = FactoryGirl.create(:item) }

  subject { @item }

  it { should be_valid }

  describe "when auction is blank" do
    skip do
    before { @item.auction = nil }
    it { should_not be_valid }
    end
  end

  describe "when user is blank" do
    skip do
    before { @item.user = nil }
    it { should_not be_valid }
    end
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