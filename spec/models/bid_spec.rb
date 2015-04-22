describe Bid do
  describe 'validations' do
    before(:each) { @bid = Bid.new(user_id: 1, item_id: 1, amount: 100) }
    subject { @bid }

    it 'sample bid is valid' do
      expect(@bid).to be_valid
    end

    it "rejects a blank user_id" do
      @bid.user = nil
      expect(@bid).to be_invalid
    end

    it "rejects a blank item_id" do
      @bid.item = nil
      expect(@bid).to be_invalid
    end

    it "rejects a blank amount" do
      @bid.amount = ''
      expect(@bid).to be_invalid
    end

    it "requires a numeric amount" do
      @bid.amount = 'one hundred million'
      expect(@bid).to be_invalid
    end

    it "requires an amount > 0" do
      @bid.amount = 0
      expect(@bid).to be_invalid
    end
  end
end