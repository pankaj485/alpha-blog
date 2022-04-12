# importing test_helper for testing purpose. It comes by default with rails
require "test_helper"

# in order to test, inherit from ActiveSupport superclass
class CategoryTest < ActiveSupport::TestCase

  # creating an instance variable before running test case.
  def setup
    # initializing category instance variable.
    @category = Category.new(name: "sports")
  end

  # creating a test block to check if category model is present.
  test "category should be valid" do
    # assert category to be valid
    assert @category.valid?
  end

  test "name should be present" do
    # creating non-passing attribute of instance variable.
    @category.name = ""
    assert_not @category.valid?
  end

  test "name should be unique" do
    # creating 2 instance variables in order to check uniqueness
    @category.save
    @category2 = Category.new(name: "sportsman")
    assert @category2.valid?
  end

  test "name should not be too long" do
    @category.name = "a" * 33
    assert_not @category.valid?
  end

  test "name should not be too short" do
    @category.name = "a" * 2
    assert_not @category.valid?
  end
end
