class Customer < ApplicationRecord
  has_one :cart,dependent: :destroy#   如果是destroy，会报错，因为cart里面有外键，不能直接删除  那么提示需要传递参数id？
  has_many :orders,through: :cart,source: :orders
  has_many :addresses
  belongs_to :user,dependent: :delete
end
