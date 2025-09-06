class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  # TODO: lógica para marcar o carrinho como abandonado e remover se abandonado
end
