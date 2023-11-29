class AddImageToCommodity < ActiveRecord::Migration[7.0]
  def change
    add_reference :commodities, :image, :null => true, :foreign_key => false
  end
end
