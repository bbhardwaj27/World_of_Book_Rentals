class ReviewsController < ApplicationController

  def show
    logger.info "We are in ReviewsController show"
    @book = Book.find(params[:book_id])
    @review = Review.new

    logger.info @book
    logger.info "We are in ReviewsController show"
  end

  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to book_path(@book)
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to book_path(@review.book)
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
