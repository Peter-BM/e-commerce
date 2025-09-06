class CartsController < ApplicationController
  
  def create
    @cart = find_or_create_cart
    render json: @cart.as_json, status: :created
  end 

  private 

  def cart_params
    params.require(:cart).permit(:total_price, :status, :last_interation_at, :abandoned_at) 
  end

  def find_or_create_cart
    current_cart = session[:cart_id]

    if current_cart.present?
      @cart ||= Cart.find_by(id: session[:cart_id])
    else
      @cart = Cart.create!(last_interation_at: Time.current,
                           status: 'active')
      session[:cart_id] = @cart.id
    end
  end

end
