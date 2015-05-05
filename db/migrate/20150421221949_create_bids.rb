class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.references :item, index: true
      t.references :user, index: true
      t.integer :amount

      t.timestamps
    end
  end
end
