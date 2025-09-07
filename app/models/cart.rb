class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  before_save :sum_total_price

  scope :inactive_since,  -> (time) { where(status: "active").where("last_interation_at < ?", time)}
  scope :abandoned_since, -> (time) { where(status: "abandoned").where("abandoned_at < ?", time) }

  def sum_total_price
    self.total_price = self.cart_items.sum(&:total_price)
  end
end
