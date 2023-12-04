class Shop < ApplicationRecord
  belongs_to :seller
  has_many :commodities, dependent: :delete_all
  has_one_attached :image, dependent: :destroy
  validates_presence_of :shop_name, :info
end
