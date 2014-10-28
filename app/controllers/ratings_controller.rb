class RatingsController < ApplicationController
  include SessionsHelper
  def update
    #get product id
    product_id = params[:id]
    #get user id
    user_id = current_user.id
    #get rating for the product
    user_rating_value = Integer(params[:rating_value])
    #if user already rated update the rating
    user_product_rating = Rating.where('user_id = ? and product_id = ?',user_id,product_id)
    if user_product_rating.length == 1
      user_product_rating[0].update_attributes(rating_value:user_rating_value)
    else
      #else create a new rating
      Rating.create(user_id:user_id, product_id:product_id, rating_value: user_rating_value)
    end
    flash[:info] = "Your rating has successfully been saved"
    redirect_to product_path(product_id)
  end
end
