class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  before_save :sum_total_price

  # TODO: lógica para marcar o carrinho como abandonado e remover se abandonado

  def sum_total_price
    self.total_price = self.cart_items.sum(&:total_price)
  end
end
