require "test_helper"

class ReviewSubmissionTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    # Other users, so a randomly picked author would be caught.
    2.times { |i| create_user(email: "other#{i}@example.com") }
    @book = create_book(user: @user)
    sign_in @user
  end

  test "a valid review is credited to the signed-in user" do
    assert_difference("Review.count", 1) do
      post book_reviews_path(@book), params: { review: { comment: "Loved it", rating: 5 } }
    end
    assert_redirected_to book_path(@book)
    assert_equal @user, Review.last.user
    assert_equal @book, Review.last.book
  end

  test "an invalid review re-renders the form with errors" do
    assert_no_difference("Review.count") do
      post book_reviews_path(@book), params: { review: { comment: "", rating: "" } }
    end
    assert_response :unprocessable_entity
    assert_select "form"
    assert_select ".invalid-feedback"
  end
end
