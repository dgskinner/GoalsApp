class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def current_user
    nil || User.find_by(session_token: session[:session_token])
  end
  
  def logged_in?
    !!current_user
  end
  
  def log_in!(user)
    session[:session_token] = user.reset_session_token!
  end
  
  def log_out!
    current_user.reset_session_token!
    session[:session_token] = nil
  end
  
  def require_logged_in
    unless logged_in?
      redirect_to new_session_url
    end
  end
end
