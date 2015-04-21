class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.references :charity, index: true
      t.datetime :start
      t.datetime :finish

      t.timestamps
    end
  end
end
