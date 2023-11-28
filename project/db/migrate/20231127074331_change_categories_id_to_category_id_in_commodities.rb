class ChangeCategoriesIdToCategoryIdInCommodities < ActiveRecord::Migration[6.0] # 使用你的 Rails 版本
  def change
    rename_column :commodities, :categories_id, :category_id
  end
end
