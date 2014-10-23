class OrdersController < ApplicationController
  include SessionsHelper, CartsHelper
  before_filter :isLoggedIn
  def create

    # check if the user id logged in, if not redirect him to login page
    redirect_to signin_path if !logged_in? && getCartItemsCount > 0

    # load cart from cookies
    @cart = JSON.parse(cookies[:shopping_cart])

    #delete the shopping cart cookies
    cookies.delete(:shopping_cart)

    # get current user details
    @user = User.find_by_id(current_user)

    # insert userid into order table and get the order id from orders table
    @order = Order.create!(user_id: @user.id, address: @user.address)

    # get the products details of the cart items
    @new_order_items = []

    #intiate sum = 0 to calculate the total cost of the order
    sum = 0;

    @cart.each do |product,quantity|
      # get the product object and convert it into an hash
      p = Product.find_by_id!(product).attributes
      p["quantity"] = quantity
      sum = sum + ( quantity * p["cost"] )
      @new_order_items.push(p)
    end

    #update the total amount of the order in orders table
    @order.update_attribute(:amount,sum)

    # iterate over the order_items and do the following for each of them
    @new_order_items.each do |new_order_item|
      # insert order_id, product_id, :price, :quantity in the order_item table
      OrderItem.create(order_id: @order.id,
                       product_id: new_order_item["id"],
                       quantity: new_order_item["quantity"],
                       price: new_order_item["cost"],
                       product_name: "#{new_order_item['manufacturer']} #{new_order_item['name']}")
    end

    # redirect the user to his order history page
    puts current_user.id
    redirect_to user_order_path(current_user.id,@order.id)
  end


  def show
    order_id = params[:id]
    user_id = params[:user_id]
    @order = Order.find_by_id!(order_id)
    #check if the order belongs to the current user
    redirect_to user_orders_path(current_user.id) if @order.user.id != current_user.id
    #get the list of order items present in the order
    @display_order_items = @order.order_items
  end

  def index
    #if the user_id is not of the current user then redirect
    redirect_to user_orders_path(current_user.id) if current_user.id != Integer(params[:user_id])
    #get the current user id
    @user = User.find_by_id!(current_user.id)
    #get list of all the orders of the current user
    #if there are search parameters get the order by id else get all the orders
    if params[:search] && params[:search] != ""
      @list_of_orders = @user.orders.where('id = ?',params[:search])
    else
      @list_of_orders = @user.orders.order("created_at DESC")
    end
  end
end
