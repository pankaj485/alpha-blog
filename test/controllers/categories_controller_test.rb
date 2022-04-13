require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    # creating a category isntance variable and also add into table.
    # adding is important since based on data controller actions are used.
    @category = Category.create(name: "sports")
  end

  # check index action
  test "should get index" do
    get categories_url
    assert_response :success
  end

  # check new action
  test "should get new" do
    get new_category_url
    assert_response :success
  end

  # check creation of category.
  test "should create category" do
    # category count should change by 1 if we create one
    # verifying that category count is changed by 1 after creation
    assert_difference("Category.count", 1) do
      # creating a post request to categories_url with the params provided
      post categories_url, params: { category: { name: "Travel" } }
    end

    assert_redirected_to category_url(Category.last)
  end

  # check show action for the instance varaible created.
  test "should show category" do
    get category_url(@category)
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_category_url(@category)
  #   assert_response :success
  # end

  # test "should update category" do
  #   patch category_url(@category), params: { category: {} }
  #   assert_redirected_to category_url(@category)
  # end

  # test "should destroy category" do
  #   assert_difference("Category.count", -1) do
  #     delete category_url(@category)
  #   end

  #   assert_redirected_to categories_url
  # end
end
