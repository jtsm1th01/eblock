class CreateWatchListItems < ActiveRecord::Migration
  def change
    create_table :watch_list_items do |t|
      t.references :item, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
