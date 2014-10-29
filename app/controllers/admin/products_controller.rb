class Admin::ProductsController < ApplicationController
  include SessionsHelper
  before_filter :authenticate_admin
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
      flash[:success] = "Product has been added to the catalog"
      redirect_to admin_products_path
    else
      render 'new'
    end
  end

  def update
    @product = Product.find_by_id(params[:id])
    if @product.update_attributes(params[:product])
      flash[:success] = "Product details have been updated"
      render 'edit'
    else
      render 'edit'
    end
  end

  def destroy
    Product.find_by_id(params[:id]).destroy
    flash[:success] = "Product has been removed successfully"
    redirect_to admin_products_path
  end

  def index
    @products = Product.search(params[:search])
  end

end
