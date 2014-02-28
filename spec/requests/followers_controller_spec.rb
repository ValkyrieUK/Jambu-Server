require 'spec_helper'

describe 'Followers API' , type: :api do

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
    @friendship = Friendship.create(
      user_id: @user.id, friend_id: @friend.id)
  end

  it 'should return a list of people following a given user' do
    get "api/v1/followers/#{@friend.uid}"
    response.status.should be(200)
    expect(response).to be_success
    expect(json['followers'].first['uid']).to eq(@user.uid)
    expect(json['followers'].first['username']).to eq(@user.username)
    expect(json['followers'].first['full_name']).to eq(@user.full_name)
    expect(json['followers'].first['image_url']).to eq(@user.image_url)
    expect(json['followers'].first['provider']).to eq(@user.provider)
  end
end
