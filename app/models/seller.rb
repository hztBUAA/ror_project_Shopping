class Seller < ApplicationRecord
  has_many :shops,dependent: :delete_all
end
