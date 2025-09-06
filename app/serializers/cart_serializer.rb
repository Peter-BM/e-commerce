class CartSerializer
  def initialize(cart) = (@cart = cart)

  def as_json(*)
    items = @cart.cart_items.includes(:product)
    {
      id: @cart.id,
      products: items.map do |item|
        {
          id: item.product_id,
          name: item.product.name,
          quantity: item.quantity,
          unit_price: item.product.unit_price,
          total_price: item.total_price
        }
      end,
      total_price: @cart.total_price
    }
  end
end
