class Cart < ApplicationRecord
  has_many :orders, dependent: :destroy
  belongs_to :customer, dependent: :destroy
end
