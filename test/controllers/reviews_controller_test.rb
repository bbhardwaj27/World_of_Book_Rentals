require "test_helper"

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    @book = create_book(user: @user)
    sign_in @user
  end

  test "should get the write-a-review page" do
    get book_review_url(@book, @book)
    assert_response :success
    assert_select "form"
  end

  test "should destroy a review" do
    review = Review.create!(user: @user, book: @book, comment: "Great", rating: 4)
    assert_difference("Review.count", -1) do
      delete book_review_url(@book, review)
    end
    assert_redirected_to book_path(@book)
  end
end
