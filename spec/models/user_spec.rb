describe User do
  
  before(:each) { @user = User.new(email: 's.name@something.com', fname: 'first', lname: 'last') }
  
  subject { @user }
  
  it { should be_valid }
  
  describe "when email is blank" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  
  describe "when first name is blank" do
    before { @user.fname = " " }
    it { should_not be_valid }
  end
  
  describe "when last name is blank" do
    before { @user.lname = " " }
    it { should_not be_valid }
  end

end