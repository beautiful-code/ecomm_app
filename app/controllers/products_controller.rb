class ProductsController < ApplicationController
  include SessionsHelper
  def show
    @product = Product.find_by_id(params[:id])
    #fetch all the reviews for the product
    @reviews_array = @product.reviews.order("created_at DESC")
    #fetch all the user names associated with the reviews
    @review_user_array = []
    @current_user_review = false
    @reviews_array.each do |review|
      temp_review = review.attributes
      temp_review["user_name"] = review.user["name"]
      @current_user_review = true if review["user_id"] == current_user.id
      @review_user_array.push(temp_review)
    end
    #get user rating for the product
    user_product_rating_array = @product.ratings.where('user_id = ?',current_user.id)
    if user_product_rating_array.length == 1
      @user_product_rating = user_product_rating_array[0][:rating_value]
    else
      @user_product_rating = 0
    end
    #get average rating for the product
    @product_avg_rating = @product.ratings.average('rating_value') || 0
  end

  def index
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
