class ProductsController < ApplicationController

  def show
    @product = Product.find_by_id(params[:id])
  end

  def index
    @products = Product.search(params[:search])
    @companies = Product.select(:manufacturer).uniq
  end

  def update
    @product = Product.find_by_id(params[:id])
    if @product.update_attributes(params[:product])
      render 'edit'
    else
      render 'edit'
    end
  end

end
