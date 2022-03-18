class ArticlesController < ActionController::Base
  layout "application"

  def show
    @article = Article.find(params[:id])
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
    @article = Article.new(params.require(:article).permit(:title, :description))

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
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(params.require(:article).permit(:title, :description))
      flash[:notice] = "Article updated successfully"
      redirect_to @article
    else
      flash[:notice] = "couldn't update "
      render "edit"
    end
    @data_received = params[:article]
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:notice] = "deleted id #{params[:id]} entry "
      redirect_to articles_path
    end
  end
end
