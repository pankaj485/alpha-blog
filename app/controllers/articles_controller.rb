class ArticlesController < ApplicationController
  # layout "application"

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def show
    @entry_num = params[:id]
  end

  def index
    @articles = Article.all
  end

  def new
    # pre populating in order to pass it to template file so that even if entry isn't succesful, we won't get nil error for intance variable
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      # flash is built in ruby method
      # showing flash display on sucesful saving
      flash[:notice] = "Article was created successfully"
      # redirecting to /article/<id>
      redirect_to @article
    else
      # render the new.html.erb page whith list of errors
      flash[:alert] = "Article was not created "
      render "new"
    end
    # show the param data recived from the form
    # render plain: @article.inspect
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article updated successfully"
      redirect_to @article
    else
      flash[:notice] = "couldn't update "
      render "edit"
    end
    @data_received = params[:article]
  end

  def destroy
    if @article.destroy
      flash[:notice] = "deleted id #{params[:id]} entry "
      redirect_to articles_path
    end
  end

  private

  # private method to get theparticular entry based on id
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
