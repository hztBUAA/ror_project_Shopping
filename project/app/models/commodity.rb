class Commodity < ApplicationRecord
  belongs_to :category
  belongs_to :shop
  belongs_to :seller
  has_many :orders,dependent: :destroy
  has_one_attached :image,dependent: :destroy
  validates :commodity_name, presence: true
end
