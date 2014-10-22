class CartsController < ApplicationController
  include CartsHelper, SessionsHelper

  def show
    #get cart
    @cart = JSON.parse(cookies[:shopping_cart] || '{}')
    #load items in the cart
    @order_list = []
    @cart.each do |cart_item_id,quantity|

      p = Product.find_by_id(Integer(cart_item_id))
      p[:quantity] = quantity
      p[:address] = current_user.address if current_user
      @order_list.push(p)
    end
  end

  def remove_item
    #get cart items
    cart = JSON.parse( cookies[:shopping_cart] || '{}' )
    #delete the required item from cart
    cart.delete(params[:p_id])
    #load the cart back to cookies
    cookies.permanent[:shopping_cart] = cart.to_json
    redirect_to cart_path
  end


  def update
    product_id = params[:cart][:product_id]
    #get cookies
    cart = JSON.parse(cookies[:shopping_cart] || '{}')
    # check if item is present in cart
    cart[product_id] = cart[product_id].to_i + 1
    # if quantity of the product has been passed, update the quantity
    cart[product_id] = Integer(params[:cart][:quantity]) if params[:cart][:quantity]
    #store back the cookies set
    cookies.permanent[:shopping_cart] = cart.to_json
    #redirect to cart page or product page
    if !params[:cart][:quantity]
      redirect_to product_path(product_id)
    else
      redirect_to cart_path
    end
  end

end
