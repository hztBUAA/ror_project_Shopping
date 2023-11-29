class AddCountToCommodity < ActiveRecord::Migration[7.0]
  def change
    add_column :commodities,:count,:integer,foreign_key:false
  end
end
;