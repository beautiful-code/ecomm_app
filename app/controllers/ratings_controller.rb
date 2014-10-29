class RatingsController < ApplicationController
  include SessionsHelper
  before_filter :authenticate_user


  def update
    #get product id
    product_id = params[:id]
    #get user id
    user_id = current_user.id
    #get rating for the product
    rating_value = params[:rating_value].to_i
    #if user already rated update the rating
    rating = Rating.where('user_id = ? and product_id = ?',user_id,product_id).first
    # rating = Rating.where(user_id: user_id,product_id: product_id).first
    if rating
      rating.update_attributes(rating_value: rating_value)
    else
      #else create a new rating
      Rating.create(user_id:user_id, product_id:product_id, rating_value: rating_value)
    end
    flash[:info] = "Your rating has successfully been saved"
    redirect_to product_path(product_id)
  end
end
