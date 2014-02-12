require 'spec_helper'

describe 'Users API' , type: :api do
  before(:each) do
    @user = User.create(
      provider: 'twitter', username: 'BillyBob', 
      image_url: 'http://...', image_thumbnail: 'http:..', 
      full_name: 'Bill Bob', uid: '1234', colour: 'blue')
    @friend = User.create(
      provider: 'twitter', username: 'Jimmy',
      image_url: 'http://...', image_thumbnail: 'http:..',
      full_name: 'Bill Bob', uid: '928',
      colour: 'blue')
    @friendship = Friendship.create(
      user_id: @user.id, friend_id: @friend_id)
  end

  it 'should return a a count of a users friends' do
    get "api/v1/count/#{@user.uid}"
    response.status.should be(200)
    expect(json['friends']).to eq(@user.friends.count)
  end
end