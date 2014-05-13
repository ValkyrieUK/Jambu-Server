# Application Controller
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery
  before_filter :authenticate

  def authenticate
    puts '***************'
    puts 'NEW API REQUEST'
    puts '***************'
    # api_auth
  end
  
  def api_auth
    key = response.headers['api-key']
    if key != ENV['API-KEY']
      render status: 401
      return
    else
      user_auth
    end
  end

  def user_auth
    auth_token = response.headers['user-token']
    User.find_by(auth_token: auth_token)
  end
end
