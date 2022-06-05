class ReviewsController < ApplicationController

  def show
    logger.info "We are in ReviewsController show"
    @book = Book.find(params[:book_id])
    @review = Review.new
    logger.info @book
    logger.info "We are in ReviewsController show"
  end

  def create
    @review = Review.new(review_params)
    @book = Book.find(params[:book_id])
    @review.book_id = params[:book_id]
    @review.comment = params[:comment]
    logger.info "Book Id : " + params[:book_id] + " Comment : " + params[:review][:comment]
    if @review.save
      logger.info "Save worked Yippe !"
      redirect_to book_path(@book)
    else
      logger.info "Save failed !"
      # render 'books/show'
      # render 'review/show'
      redirect_to book_path(@book)
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to book_path(@review.book)
  end

  private

  def review_params
    # params.require(:comment).permit(:rating)
  end
end
