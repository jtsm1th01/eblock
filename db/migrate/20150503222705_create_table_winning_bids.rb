class CreateTableWinningBids < ActiveRecord::Migration
  def change
    create_table :winning_bids do |t|
      t.references :bid, index: true
      t.references :item, index: true
    end
  end
end
