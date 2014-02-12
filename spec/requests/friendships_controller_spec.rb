require 'spec_helper'

describe 'Users API' , type: :api do

  it 'should return a array of all friendships' do
    get 'api/v1/friendships'
    response.status.should be(200)
  end

  it 'should return a array of friends for user' do
    user = FactoryGirl.create(:user)
    get "api/v1/friendships/#{user.id}"
    response.status.should be(200)
  end

  it 'should create a new friendship' do
    post 'api/v1/friendships', friendship: { user_id: 1, friend_uid: 2 }
    response.status.should be(201)
  end

  it 'should be able to delte a friendship' do
    @friendship = Friendship.create(
      user_id: 1, friend_id: 2)
    Friendship.count.should be 1
    delete "api/v1/friendships/#{@friendship.id}"
    Friendship.count.should be 0
  end
end
