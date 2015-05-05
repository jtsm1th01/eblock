class AddNameToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :name, :string
  end
end
