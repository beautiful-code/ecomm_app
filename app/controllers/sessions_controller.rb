class SessionsController < ApplicationController
  def new
  end

  def create
    @user =  User.find_by_email!(params[:session][:email])
    if (@user.authenticate(params[:session][:password]))
      if params[:session][:remember_me] == "1"
        cookies.permanent[:ecomm_app_remember_token] = @user.remember_token
      else
        cookies[:ecomm_app_remember_token] = @user.remember_token
      end
        #self.current_user = @user
        redirect_to root_path
    else
      redirect_to signin_path
    end
  end

  def destroy
    cookies.delete(:ecomm_app_remember_token)
    cookies.delete(:ecomm_app_cart)
    redirect_to root_path
  end
end