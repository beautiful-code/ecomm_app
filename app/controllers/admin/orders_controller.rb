class Admin::OrdersController < ApplicationController
  include SessionsHelper
  before_filter :authenticate_admin

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
    modified_order = Order.find_by_id!(order_id)
    #if order status is dispatched send a mail to user
    if order_status == "in_transit"
      list_of_products = modified_order.order_items
      UserMailer.dispatch_notification_mail(modified_order.user_id,modified_order.id,list_of_products).deliver!
    end
    #redirect to update orders page
    flash[:info] = "The order status has been updated successfully"
    redirect_to edit_admin_orders_path
  end
end
