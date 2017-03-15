class CartsController < ApplicationController
  before_action :set_cart, only: [:checkout]

  def show
    @current_cart = current_user.current_cart
  end

  def checkout
    @cart.checkout_cart
    redirect_to @cart
  end

  private
  
  def set_cart
    @cart = Cart.find(params[:id])
  end
end
