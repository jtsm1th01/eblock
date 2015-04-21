describe User do
  
  it "should be valid" do
    user = User.new(email: 's.name@something.com', fname: 'first', lname: 'last')
    expect(user).to be_valid
  end
  
end