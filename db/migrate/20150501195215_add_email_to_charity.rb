class AddEmailToCharity < ActiveRecord::Migration
  def change
    add_column :charities, :email, :text
  end
end
