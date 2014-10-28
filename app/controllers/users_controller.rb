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

  def edit
    @user = current_user
  end

  def update
    @user = User.find_by_id(current_user.id)
    print params
    if @user.update_attributes(params[:user])
      signin_user @user
      flash[:info] = "Updated successfully"
    end
    redirect_to edit_user_path(current_user.id)
  end
end
