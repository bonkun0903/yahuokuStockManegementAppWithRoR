class Shelf < ApplicationRecord
  has_many :products
  accepts_nested_attributes_for :products

  validates :shelf_code, presence: true
end
