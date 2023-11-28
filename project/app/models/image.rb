class Image < ApplicationRecord
  has_one_attached :image
  validates :image, content_type: { in: %w[image/jpeg image/png image/gif], message: 'must be a valid image format' },
            size: { less_than: 5.megabytes, message: 'should be less than 5MB' }
end
