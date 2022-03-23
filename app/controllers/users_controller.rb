class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated"
      redirect_to user_path(@user)
    else
      flash[:error] = "Your account information was not updated"
      render "edit"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # instantly log in user as signs up
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the Alpha Blog, #{@user.username} You have succesfully singed up"
      redirect_to articles_path
    else
      flash[:error] = "Couldn't register. Please try again."
      render "new"
    end
  end

  def destroy
    # removing user from database
    # @user is populated with set_user method
    @user.destroy
    # removing the session
    session[:user_id] = nil
    flash[:notice] = "Account and all associated articels deleted !"
    redirect_to articles_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    # @user is already populated through set_user method to the respective actions
    if current_user != @user
      flash[:alert] = "You can only edit your own account"
      redirect_to @user
    end
  end
end
