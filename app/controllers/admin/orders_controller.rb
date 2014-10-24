class Admin::OrdersController < ApplicationController
  include SessionsHelper
  before_filter :isAdmin

  def edit
    #get all the list of orders
    @orders = Order.order('created_at DESC')
    #store order_items of the orders in a hash
    @order_items = {}
    @orders.each do |order|
      @order_items[order.id] =  order.order_items
    end
  end

  def update
    #get the order id and order status
    order_id = params[:order][:id]
    order_status = params[:order][:status]
    #update the order status
    Order.find_by_id!(order_id).update_attribute('status',order_status)
    #redirect to update orders page
    redirect_to edit_admin_orders_path
  end
end
