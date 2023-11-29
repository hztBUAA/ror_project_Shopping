class Commodity < ApplicationRecord
  belongs_to :category
  belongs_to :shop
  belongs_to :seller
  has_many :orders,dependent: :destroy
  has_one_attached :image,dependent: :destroy
  validates_presence_of :commodity_name, :price, :count, :info, :category_id
end
