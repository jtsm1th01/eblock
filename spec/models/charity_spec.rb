describe Charity do
  
  it "should be valid" do
    charity = Charity.new(name: 'NorCal Austism Research Foundation')
    expect(charity).to be_valid
  end
  
end
