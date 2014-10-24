class ProductsController < ApplicationController

  def show
    @product = Product.find_by_id(params[:id])
  end

  def index
    #puts "Params are #{params}"
    @products = Product.search(params[:search])
    @products = Product.search(params[:company_filter])
    @companies = Product.select(:manufacturer).uniq
    @companies_in_search_field = params[:company_filter] || []
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
