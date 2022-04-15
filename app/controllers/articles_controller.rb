class ArticlesController < ApplicationController
  # layout "application"

  # getting user based on params and populating to respective actions
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # if not logged in then only allow show and index actions
  before_action :require_user, except: [:show, :index]
  # if logged in which is based on requrire_user, verfies if the article author and logged in user are same
  before_action :require_same_user, only: [:edit, :update, :destory]

  def show
    @entry_num = params[:id]
  end

  def index
    # @articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 3)
    @users = User.all
  end

  def new
    # pre populating in order to pass it to template file so that even if entry isn't succesful, we won't get nil error for intance variable
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    # using helper method defined in application_controller to get the current user
    @article.user = current_user

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
      flash[:alert] = "couldn't update "
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
    #  category_ids is plural insted of category_id since it is many-to-many association
    params.require(:article).permit(:title, :description, category_ids: [])
  end
end
