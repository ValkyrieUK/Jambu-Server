require 'spec_helper'

describe 'Friendship API' , type: :api do
  before(:each) do
    @user = User.create(
      provider: 'twitter', username: 'BillyBob',
      image_url: 'http://...', image_thumbnail: 'http:..',
      full_name: 'Bill Bob', uid: '12134', colour: 'blue',
      device_token: 'NONE')
    @friend = User.create(
      provider: 'twitter', username: 'Jimmy',
      image_url: 'http://...', image_thumbnail: 'http:..',
      full_name: 'Billdsf Bob', uid: '92811',
      colour: 'blue', device_token: 'NONE')
  end

  it 'should resquest a uid' do
    get 'api/v1/friendships' 
    response.status.should be(200)
  end

  it 'should return a array of friends for user' do
    user = FactoryGirl.create(:user)
    get "api/v1/friendships/#{user.id}"
    response.status.should be(200)
  end

  it 'should create a new friendship' do
    post 'api/v1/friendships', friendship: { user_id: @user.id, friend_id: @friend.id }
    response.status.should be(201)
  end

  it 'should be able to delte a friendship' do
    @friendship = Friendship.create(
      user_id: @user.id, friend_id: @friend.id)
    Friendship.count.should be 1
    delete "api/v1/friendships/#{@friendship.id}"
    Friendship.count.should be 0
  end
end
