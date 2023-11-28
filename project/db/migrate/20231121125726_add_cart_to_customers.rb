class AddCartToCustomers < ActiveRecord::Migration[7.0]
  def change
    add_reference :customers, :cart, foreign_key: true
  end
end
