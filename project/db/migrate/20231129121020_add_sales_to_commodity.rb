class AddSalesToCommodity < ActiveRecord::Migration[7.0]
  def change
    add_column :commodities, :sales, :integer, default: 0
  end
end
