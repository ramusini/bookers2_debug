require "test_helper"

class BookComments　createControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get book_comments　create_destroy_url
    assert_response :success
  end
end
