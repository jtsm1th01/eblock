class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :auction, index: true
      t.references :user, index: true
      t.string :name
      t.text :description
      t.integer :value

      t.timestamps
    end
  end
end
