class CartsController < ApplicationController
  
  def create
    cart = find_or_create_cart
    cart = AddItemToCartService.call(cart, cart_params[:product_id], cart_params[:quantity])
    session[:cart_id] ||= cart.id
    
    render json: CartSerializer.new(cart).as_json, status: :created

    rescue ActiveRecord::RecordNotFound
      render json: { error: "Produto não encontrado" }, status: :not_found
    rescue ActionController::ParameterMissing
      render json: { error: "Produto e quantidade devem ser informados" }, status: :bad_request
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.record.errors.full_messages }, status: :unprocessable_entity
  end 

  private 

  def cart_params
    params.require(:product_id)
    params.require(:quantity)
    params.permit(:product_id, :quantity)
  end

  def find_or_create_cart
    current_cart = session[:cart_id]

    if current_cart.present?
      cart = Cart.find_by(id: session[:cart_id])
    else
      cart = Cart.create!(last_interation_at: Time.current,
                           status: 'active')
    end
  end

end
