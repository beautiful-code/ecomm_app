class UserMailer < ActionMailer::Base
  default from: "admin@ecommapp.com"

  def registration_email(user)
    @user = user
    mail(to: @user.email, subject: "Thank you for registering")
  end

  def dispatch_notification_mail(user_id,order_id,list_of_products)
    @user = User.find_by_id(user_id)
    @order_id = order_id
    @list_of_products = list_of_products
    mail(to: @user.email, subject: "Your Order ##{@order_id} has been dispatched")
  end
end
