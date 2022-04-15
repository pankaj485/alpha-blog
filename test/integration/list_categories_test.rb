require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest

  # test 2 categories to make sure they show up, and also is clickable links
  def setup
    @category = Category.create(name: "Sports")
    @category2 = Category.create(name: "Travel")
  end

  test "should show categories listing" do
    # visiti categories index path
    get "/categories"

    # look for a link in the page which mateches to the @<category_name>.name
    # also, passing the text of link as name of the category
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end
end
