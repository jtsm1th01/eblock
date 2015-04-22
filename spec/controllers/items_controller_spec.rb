RSpec.describe ItemsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "GET #show" do
    it "returns http success" do
      FactoryGirl.create(:item)
      get :show, :id => 1
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "POST #create" do
    pending
    context "with valid item" do
      it "creates new item" do
        item_attributes = FactoryGirl.attributes_for(:item)
        post :create, post: item_attributes
        expect(Item.last).to eq(Item.new(item_attributes))
      end
    end
  end

end
