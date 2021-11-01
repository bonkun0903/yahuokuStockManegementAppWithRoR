class Shelf < ApplicationRecord
  has_many :products

  validates :shelf_code, presence: true
end
