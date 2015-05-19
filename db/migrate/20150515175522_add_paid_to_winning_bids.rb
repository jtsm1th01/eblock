class AddPaidToWinningBids < ActiveRecord::Migration
  def change
    add_column :winning_bids, :paid, :boolean, default: false
  end
end
