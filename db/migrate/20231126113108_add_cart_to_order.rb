class AddCartToOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders,:cart,foreign_key:true
  end
end
