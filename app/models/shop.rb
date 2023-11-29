class Shop < ApplicationRecord
  belongs_to :seller
  has_many :commodities, dependent: :delete_all
  validates_presence_of :shop_name, :info
end
