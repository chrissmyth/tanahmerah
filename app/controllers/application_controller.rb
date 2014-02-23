class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  if Rails.env.test?
    prepend_before_filter :stub_current_user
  end

  before_filter :set_current_user


  protected # prevents method from being invoked by a route
 
  def stub_current_user
    debugger
    session[:user_id] = cookies[:stub_user_id] if cookies[:stub_user_id]
  end

  def set_current_user
    debugger
    # we exploit the fact that find_by_id(nil) returns nil
    @current_user ||= User.find_by_id(session[:user_id])
    redirect_to login_path and return unless @current_user
  end

end
