class Seller < ApplicationRecord
  has_many :shops
  has_many :commodities,through: :shops
  has_many :orders,through: :commodities
  belongs_to :user
end
