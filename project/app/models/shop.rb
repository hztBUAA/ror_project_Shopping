class Shop < ApplicationRecord
  belongs_to :seller,dependent: :destroy
  has_many :commodities, dependent: :destroy
end
