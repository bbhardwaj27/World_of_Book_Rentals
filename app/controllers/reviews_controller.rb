class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    @book = Book.find(params[:book_id])
    @review.book = @book
    if @review.save
      redirect_to book_path(@book)
    else
      render 'books/show'
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
