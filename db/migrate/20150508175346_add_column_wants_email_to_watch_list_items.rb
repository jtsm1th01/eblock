class AddColumnWantsEmailToWatchListItems < ActiveRecord::Migration
  def change
    add_column :watch_list_items, :wants_email, :boolean, :default => false
  end
end
