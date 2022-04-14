require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get new category form and create category" do
    # get new categories path
    get "/categories/new"
    # verify the path is giving success response
    assert_response :success
    assert_difference("Category.count", 1) do
      # creating a post request to categories_url with the params provided
      post categories_url, params: { category: { name: "Sports" } }
      # redirect to category once category is created.
      assert_response :redirect
    end
    # ensuere successful redirection
    follow_redirect!
    assert_response :success

    # make sure to match the content is present after redirection
    assert_match "Sports", response.body
  end
end
