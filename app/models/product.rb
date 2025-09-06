class Product < ApplicationRecord
  has_many :carts, through: :cart_items

  validates_presence_of :name, :unit_price
  validates_numericality_of :unit_price, greater_than_or_equal_to: 0
end
