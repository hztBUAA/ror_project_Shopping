class AddSellerAndShopToCommodity < ActiveRecord::Migration[7.0]
  def change
    # t.references :shop, foreign_key: true
    # t.references :seller, foreign_key: true
    add_reference :commodities, :seller, foreign_key: true
    # add_reference :commodities, :shop, foreign_key: true
  end
end
