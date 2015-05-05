feature 'browse_items' do
  scenario 'a guest visits the items index' do
    visit items_path
    expect(page).to have_content 'Items Up for Bid'
  end
end