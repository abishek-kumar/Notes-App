#todo enable csrf protection
class ApplicationController < ActionController::Base
  @@EMPTY_JSON_RESPONSE = {}
  before_filter :allow_cors
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

  #todo change hardcoded domain and use dev_setup check
  def allow_cors
    headers['Access-Control-Allow-Origin'] = "http://localhost:4200"
    headers['Access-Control-Allow-Credentials'] = "true"
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = "content-type"
  end

  def cors_preflight
    head :ok
  end

end
