class UserMailer < ActionMailer::Base
  default from: "ecomm_app@example.com"

  def registration_email(user)
    @user = user
    mail(to: @user.email, subject: "Thank you for registering")
  end
end
