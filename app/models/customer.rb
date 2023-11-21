class Customer < ApplicationRecord
  has_one :cart,delete_all#   如果是destroy，会报错，因为cart里面有外键，不能直接删除  那么提示需要传递参数id？
  has_many :orders,through: :cart,source: :orders
end
