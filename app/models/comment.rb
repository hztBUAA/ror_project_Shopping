class Comment < ApplicationRecord
  belongs_to :commodity
  belongs_to :customer
  validates :text, presence: true
end
