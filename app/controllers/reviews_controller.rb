class ReviewsController < ApplicationController

  include SessionsHelper
  before_filter :authenticate_user
  def create
    @review = Review.new(params[:review])
    if @review.save
      flash[:success] = "review posted"
    else
      @review.errors.full_messages.each do |msg|
        flash[:warning] = msg
      end
    end
    redirect_to product_path(params[:review][:product_id])
  end

  def index
    #get user id
    user_id = params[:user_id].to_i
    #get list of reviews
    @reviews = current_user.reviews
  end

  def update
    #get the concerned review
    review = Review.find_by_id(params[:id])
    #update the content
    if review.update_attributes(params[:review])
      flash[:notif] = "Your review has been updated"
    else
      flash[:warning] = "Error while updating your review"
    end
    redirect_to product_path(params[:review]["product_id"])
  end

end
