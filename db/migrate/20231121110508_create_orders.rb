class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :count#订单中的商品数  可能买多件
      t.decimal :price
      t.boolean :done #是否完成 之后可以根据这个进行购物车的呈现 购物车就是未完成的订单
      t.references :commodity, foreign_key: true
      t.references :customer, foreign_key: true
      t.timestamps
    end
  end
end
