class Order < ApplicationRecord
  belongs_to :commodity,dependent: :destroy  # TODO:belongs_to  has_many的删除指的是哪个删除？
  belongs_to :customer,dependent: :destroy
  #belongs_to :seller    如何数据表中没有seller_id这个字段，这个belongs_to :seller会报错吗？  不会长期保存
  validates :count, presence: true #保证数量不为空
  belongs_to :address
end
