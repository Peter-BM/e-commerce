class CartsController < ApplicationController

  before_action :set_cart, only: %i[ show add_item remove_item ]
  
  def create
    cart = find_or_create_cart
    cart = HandleProductService.add_item(cart, cart_params[:product_id], cart_params[:quantity])
    session[:cart_id] ||= cart.id
    
    render json: CartSerializer.new(cart).as_json, status: :created

    rescue ActiveRecord::RecordNotFound
      render json: { error: "Produto não encontrado" }, status: :not_found
    rescue ActionController::ParameterMissing
      render json: { error: "Produto e quantidade devem ser informados" }, status: :bad_request
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.record.errors.full_messages }, status: :unprocessable_entity
  end 
  
  def show
    
    return render json: { error: "Carrinho não encontrado" }, status: :not_found if @cart.nil?

    render json: CartSerializer.new(@cart).as_json, status: :ok
  end
  
  def add_item
    
    return render json: { error: "Carrinho não encontrado" }, status: :not_found if @cart.nil?
    
    cart = HandleProductService.add_item(@cart, cart_params[:product_id], cart_params[:quantity])
    
    render json: CartSerializer.new(cart).as_json, status: :created

    rescue ActiveRecord::RecordNotFound
      render json: { error: "Produto não encontrado" }, status: :not_found
    rescue ActionController::ParameterMissing
      render json: { error: "Produto e quantidade devem ser informados" }, status: :bad_request
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def remove_item
   return render json: { error: "Carrinho não encontrado" }, status: :not_found if @cart.nil?

    cart = HandleProductService.remove_item(@cart, params[:product_id])
    render json: CartSerializer.new(cart).as_json, status: :ok
    
    rescue ArgumentError => e
      render json: { error: e.message }, status: :bad_request
  end

  private 

  def cart_params
    params.require(:product_id)
    params.require(:quantity)
    params.permit(:product_id, :quantity)
  end

  def set_cart
    return nil if session[:cart_id].blank?
    @cart = Cart.find(session[:cart_id])
  end

  def find_or_create_cart
    current_cart = session[:cart_id]

    if current_cart.present?
      cart = Cart.find(session[:cart_id])
    else
      cart = Cart.create!(last_interation_at: Time.current,
                           status: 'active')
    end
  end

end
