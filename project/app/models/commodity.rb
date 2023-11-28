class Commodity < ApplicationRecord
  belongs_to :category
  belongs_to :shop
  belongs_to :seller
  has_one_attached :image
end
