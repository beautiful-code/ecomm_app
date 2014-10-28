class ReviewsController < ApplicationController

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

end
