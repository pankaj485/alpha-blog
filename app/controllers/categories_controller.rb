class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  def new
    @category = Category.new
  end

  def index
  end

  def show
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = " \"#{@category.name}\" Category was successfully created."
      redirect_to @category
    else
      flash[:alert] = " \"#{@category.name}\" Category was not created."
      render "new"
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
