class Commodity < ApplicationRecord
  belongs_to :category,dependent: :destroy
  belongs_to :shop, dependent: :destroy
  belongs_to :seller
  has_many :orders
  has_one_attached :image
end
