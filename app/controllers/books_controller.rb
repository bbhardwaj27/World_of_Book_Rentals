class BooksController < ApplicationController
  before_action :set_book, only: %i[ show create edit update destroy ]

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.create
  end

  def edit
  end

  def create
    @book_rentals = Book_rentals.new(book_params)

    if @book.save
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
    end


  def destroy
    @book.destroy
    redirect_to book_url, notice: "Book was successfully destroyed."
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :publishing_year, :booking, :rating)
  end
end
