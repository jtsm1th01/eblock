describe Charity do
  
before(:each) { @charity = Charity.new(name: 'NorCal Austism Research Foundation') } 
  subject { @charity }
  
  it { should be_valid }
  
  describe "when name is blank" do
    before { @charity.name = " " }
    it { should_not be_valid }
  end

end
