class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.references :customer, foreign_key: true
      #customer has many carts so cart belongs to customer and need to tell this to rails via the cart  not in customer
      t.timestamps
    end
  end
end
