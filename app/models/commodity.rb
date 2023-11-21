class Commodity < ApplicationRecord
  has_and_belongs_to_many :categories,dependent: :destroy
  belongs_to :shop,dependent: :destroy
end
