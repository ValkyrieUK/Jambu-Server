require 'spec_helper'

describe 'Is Friends API' , type: :api do
  before(:each) do
    @user = User.create(
      provider: 'twitter', username: 'BillyBob',
      image_url: 'http://...', image_thumbnail: 'http:..',
      full_name: 'Bill Bob', uid: '12134', colour: 'blue')
    @friend = User.create(
      provider: 'twitter', username: 'Jimmy',
      image_url: 'http://...', image_thumbnail: 'http:..',
      full_name: 'Billdsf Bob', uid: '92811',
      colour: 'blue')
    @friendship = Friendship.create(user_id: @user.id, friend_id: @friend.id)
  end

  xit 'should confirm if they are friends or not' do
    get "api/v1/is_friends?id=#{@user.id}&user=#{@friend.id}"
  end
end
