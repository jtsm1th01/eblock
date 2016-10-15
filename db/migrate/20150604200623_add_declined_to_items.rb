class AddDeclinedToItems < ActiveRecord::Migration
  def change
    add_column :items, :declined, :boolean, default: false 
  end
end
