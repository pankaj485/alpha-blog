require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest

  # since we added restriction on Admin level, only index and show actions are globally possible.
  # loggin in as an admin to perform rest of test cases.
  setup do
    @admin_user = User.create(username: "johndoe", email: "johndoe@example.com",
                              password: "password", admin: true)
    sign_in_as(@admin_user)
  end

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

  test "get new category form and reject invalid category submission" do
    # get new categories path
    get "/categories/new"

    # verify the path is giving success response
    assert_response :success

    # for invalid submission, differene is 0 sicne no new category will be created
    assert_no_difference("Category.count") do
      # creating a post request to categories_url with the params provided
      # providing no value so that it counts as invalid case.
      post categories_url, params: { category: { name: " " } }
    end

    # verify error by checking the content of the error messages.
    assert_match "errors", response.body

    # verify error by checking the classnames of the error elements.
    assert_select "div.alert"
    assert_select "h4.alert-heading"
  end
end
