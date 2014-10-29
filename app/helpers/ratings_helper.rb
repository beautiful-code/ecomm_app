module RatingsHelper
  def get_rating product_id
    rating=  Rating.where(product_id: product_id, user_id: current_user.id).first
    value = (rating ?  rating.rating_value :  0)
  end
end
