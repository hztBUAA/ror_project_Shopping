class Shop < ApplicationRecord
  belongs_to :seller,dependent: :delete
  has_many :commodities, dependent: :delete_all
end
