require "test_helper"

class ReviewTest < ActiveSupport::TestCase
  setup do
    @user = create_user
    @book = create_book(user: @user)
  end

  test "is invalid without a comment or rating" do
    review = Review.new(user: @user, book: @book)
    assert_not review.valid?
    assert_includes review.errors.attribute_names, :comment
    assert_includes review.errors.attribute_names, :rating
  end

  test "is invalid with a non-integer rating" do
    review = Review.new(user: @user, book: @book, comment: "Great", rating: "great")
    assert_not review.valid?
    assert_includes review.errors.attribute_names, :rating
  end

  test "is valid with a comment and an integer rating" do
    assert Review.new(user: @user, book: @book, comment: "Great", rating: 4).valid?
  end
end
