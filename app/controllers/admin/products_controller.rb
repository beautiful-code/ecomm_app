class Admin::ProductsController < ApplicationController
  include SessionsHelper
  before_filter :isAdmin
  def edit
    redirect_to root_path if !current_user.admin?
    @product = Product.find_by_id(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to admin_products_path
    else
      render 'new'
    end
  end

  def update
    @product = Product.find_by_id(params[:id])
    if @product.update_attributes(params[:product])
      render 'edit'
    else
      render 'edit'
    end
  end

  def destroy
    Product.find_by_id(params[:id]).destroy
    redirect_to admin_products_path
  end

  def index
    @products = Product.search(params[:search])
  end

end
