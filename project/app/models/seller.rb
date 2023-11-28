class Seller < ApplicationRecord
  has_many :shops,dependent: :delete_all
  has_many :commodities,through: :shops,dependent: :delete_all
  belongs_to :user,dependent: :delete
end
