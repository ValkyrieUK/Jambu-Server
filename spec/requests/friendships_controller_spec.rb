require 'spec_helper'

describe 'Users API' , type: :api do

  xit 'should return a array of all friendships' do
    get 'api/v1/friendships'
    response.status.should be(200)
  end

  xit 'should return a array of friends for user' do
    get "api/v1/friendships/#{user.uid}"
  end

  xit 'should create a new friendship' do
    post 'api/v1/users', friendship: { user_uid: '1234', friend_uid: '4321' }
    response.status.should be(201)
  end
end
