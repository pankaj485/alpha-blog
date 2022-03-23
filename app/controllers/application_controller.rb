class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    # to get the current user, get the user from database based on the session id we have on login session
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  # if user is not logged in then show flash and guide them to login path
  def require_user
    if !logged_in?
      flash[:alert] = "You need to be logged in to perform the action!!"
      redirect_to login_path
    end
  end

  # if logged in user is not author of article then that user can't perform edit or destroy. hence redirects to view only
  def require_same_user
    # @article is populated through set_article method in articles_controlelr
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "you can edit or destory your own articles only!! "
      redirect_to @article
    end
  end
end
