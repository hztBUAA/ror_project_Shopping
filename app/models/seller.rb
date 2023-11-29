class Seller < ApplicationRecord
  has_many :shops
  has_many :commodities,through: :shops
  belongs_to :user
end
