class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    # to get the current user, get the user from database based on the session id we have on login session
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end
end
