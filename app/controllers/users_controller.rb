class UsersController < ApplicationController
  include SessionsHelper
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.registration_email(@user).deliver
      flash[:success] = "Your account has been created successfully"
      signin_user @user
      redirect_to root_path
    else
      render 'new'
    end
  end
end
