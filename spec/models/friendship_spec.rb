require 'spec_helper'

describe Friendship do
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
  end

  it 'should create a friendship' do
    friendship = Friendship.create(user_id: @user.id, friend_id: @friend.id)
    friendship.save.should be true
  end

  it 'should not create a friendship that already exits' do
    friendship1 = Friendship.create(user_id: 2, friend_id: 1)
    friendship2 = Friendship.create(user_id: 2, friend_id: 1)
    friendship2.save.should be false
  end

  it 'should be able to destroy a friendship' do
    friendship = Friendship.create(user_id: 2, friend_id: 1)
    Friendship.count.should eq(1)
    friendship.destroy
    Friendship.count.should eq(0)
  end
end