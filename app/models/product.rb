class Product < ApplicationRecord
  has_one :category
  has_one_attached :featured_image
end
