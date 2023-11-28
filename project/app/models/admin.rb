class Admin < ApplicationRecord
  belongs_to :user,dependent: :delete
end
