class ApiController < ActionController::Base
  before_filter :authenticate

  def authenticate
    puts '***************'
    puts 'NEW API REQUEST'
    puts '***************'
    # api_auth
  end

  def api_auth
    key = response.headers['api-key']
    return bad_auth if key.to_s.empty?
    if key != ENV['API_KEY']
      return render bad_auth
    else
      user_auth
    end
  end

  def user_auth
    auth_token = response.headers['user-token']
    return bad_auth if auth_token.to_s.empty?
    user = User.find_by(auth_token: auth_token)
    return bad_auth unless user
  end

  def bad_auth
    render json: {status: 'bad auth token'}, status: 401
  end
end