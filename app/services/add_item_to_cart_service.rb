class AddItemToCartService

  def self.call(cart, product_id, quantity)
    product = Product.find(product_id)
    
    Cart.transaction do 
      item = cart.cart_items.find_or_initialize_by(product_id: product.id)
      
      raise ArgumentError, "Quantidade deve ser maior do que zero" if quantity <= 0
      
      if item.new_record?
        item.quantity = quantity
      else
        item.quantity += quantity
      end  

      item.total_price = item.quantity * product.unit_price
      item.save!  

      cart.update!(last_interation_at: Time.current)
    end

    cart.reload
  end
end
