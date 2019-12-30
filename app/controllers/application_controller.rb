class ApplicationController < ActionController::Base
  #protect_from_forgery
  def check_user_login
    redirect_to "/login_page" unless session[:current_user_id] != nil
  end

  def current_user_id
    @current_user_id ||= session[:current_user_id]
  end

  def clear_session
    session[:current_user_id] = nil
  end

end
