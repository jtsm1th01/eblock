class AddBidDefaultsToItems < ActiveRecord::Migration
  def change
    add_column :items, :starting_bid, :integer
    add_column :items, :bid_increment, :integer
  end
end
