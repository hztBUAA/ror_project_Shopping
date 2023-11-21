class Seller < ApplicationRecord
  has_many :shop,dependent: :delete_all
end
