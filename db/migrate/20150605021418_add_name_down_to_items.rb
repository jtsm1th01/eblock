class AddNameDownToItems < ActiveRecord::Migration
  def change
    add_column :items, :name_down, :string
    add_index :items, :name_down
  end
end
