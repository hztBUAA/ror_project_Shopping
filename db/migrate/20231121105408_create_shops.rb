class CreateShops < ActiveRecord::Migration[7.0]
  def change
    create_table :shops do |t|
      t.string :shop_name
      t.text :info
      t.references :seller, foreign_key: true
      t.timestamps
    end
  end
end
