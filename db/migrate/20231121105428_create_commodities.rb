class CreateCommodities < ActiveRecord::Migration[7.0]
  def change
    create_table :commodities do |t|
      t.string :commodity_name
      t.text :info
      t.decimal :price
      t.references :shop, foreign_key: true
      t.references :categories, foreign_key: true# TODO:如何理解这里的category复数   多对多关系需要在这里体现吗？
      #todo：index不是自己设置的？
      t.timestamps
    end
  end
end
