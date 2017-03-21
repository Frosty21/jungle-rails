class ReviewsController < ApplicationController
  before_action :require_login
  def create
    @product = Product.find(params[:product_id])
    @review - @product.reviews.create(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @product
    else
      render_to @product
    end
  end

  private
  def review_params
    params.require(:review).premit(:rating, :description)
  end

  def require_login
    return true if current_user
    flash[:error] = "Not logged in to post a review..."
    render 'products/show'
  end
end