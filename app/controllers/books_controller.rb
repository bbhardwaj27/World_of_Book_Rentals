class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy]

  def index
    @books = Book.all
  end

  def list
    @books = Book.find(all)
  end

  def show
  end

  def new
    @book = Book.new
  end

  # def review
  #   @review = Review.new
  # end

  def edit
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    # @book.review = add_review
    if @book.save!
      redirect_to @book, notice: "Book was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: "Book was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
    # if @review.update(review_params)
    #   redirect_to @review, notice: "Review was successfully updated."
    # else
    # render :edit, status: :unprocessable_entity
    # end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: "Book was successfully destroyed."
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :publishing_year, :price)
  end

  def add_review
    Review.new
  end
end
