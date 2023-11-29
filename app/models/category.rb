class Category < ApplicationRecord
  has_many :commodities, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end