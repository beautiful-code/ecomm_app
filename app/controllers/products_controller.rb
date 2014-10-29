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
      @review_user_array.push(temp_review)
    end
    #get average rating for the product
    @product_avg_rating = @product.ratings.average('rating_value') || 0
    #if user logged in
    if logged_in?
      #get user rating for the product
      user_product_rating_array = @product.ratings.where('user_id = ?',current_user.id)
      if user_product_rating_array.length == 1
        @user_product_rating = user_product_rating_array[0][:rating_value]
      else
        @user_product_rating = 0
      end
      #get user review for the product
      @user_review = @product.reviews.where('user_id = ?',current_user.id).first || Review.new
    else
      @user_product_rating = 0
      @user_review = Review.new
    end
    #get total number of rating for the product
    @total_number_of_ratings = @product.ratings.count
  end

  def index
    @products = Product.search(params[:search])
    @products = Product.search(params[:company_filter])
    @companies = Product.select(:manufacturer).uniq
    @companies_in_search_field = params[:company_filter] || []
    #get average rating of all the products
    @products_and_ratings = {}
    @products.each do |product|
      product_rating = product.ratings.average('rating_value') || 0
      @products_and_ratings["#{product.id}"] = product_rating
    end
  end

end
