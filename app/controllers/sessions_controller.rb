class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    # check if user exists and also if the password passed from form is authenticated.
    if user && user.authenticate(params[:session][:password])

      # creating session based on user id to keep user logged in
      session[:user_id] = user.id

      flash[:notice] = "Successfully Logged in as #{user.username}"
      redirect_to user
    else
      # flash works based on http cycle. once a http cycle completes, it shows up
      # while rendering, http cycle isn't actually performed due to which we use "flash.now" which renders right after flash is populated.
      flash.now[:alert] = "Couldn't verify credentials. Try again."
      render "new"
    end
  end

  def destroy
    # clearing sessin on logging out
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
  end
end
