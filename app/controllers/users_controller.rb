class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated"
      redirect_to articles_path
    else
      flash[:error] = "Your account information was not updated"
      render "edit"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to the Alpha Blog, #{@user.username} You have succesfully singed up"
      redirect_to articles_path
    else
      flash[:error] = "Couldn't register. Please try again."
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
