class AddColumnsToCharities < ActiveRecord::Migration
  def change
    add_column :charities, :subhead, :text
    add_column :charities, :url, :string
    add_column :charities, :bg_color, :string
  end
end
