class ReviewsController < ApplicationController

  def show
    logger.info "We are in ReviewsController show"
    @book = Book.find(params[:book_id])
    @review = Review.new
    logger.info @book
    logger.info "We are in ReviewsController show"
  end

  def create
    @review = Review.new
    @book = Book.find(params[:book_id])
    @review.book_id = params[:book_id]
    @review.rating = params[:review][:rating]
    @review.comment = params[:review][:comment]
    @review.user_id =

    @review = Review.create!(
      comment: params[:review][:comment],
      rating: params[:review][:rating],
      book: @book,
      user: User.all.sample
    )

    logger.info "Book Id : " + params[:book_id]
    logger.info " Comment : " + params[:review][:comment]
    logger.info " Rating : " + + params[:review][:rating]
    # logger.info "Review is : " + @review.comment + " Rating is : " + @review.rating
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
