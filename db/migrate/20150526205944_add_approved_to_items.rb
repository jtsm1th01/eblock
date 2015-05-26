class AddApprovedToItems < ActiveRecord::Migration
  def change
    add_column :items, :approved, :boolean, default: false
  end
end
