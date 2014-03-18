require 'spec_helper'

describe Activity do
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

  it 'should be able to create a Activity' do
    Activity.create(user_id: 1, action: 'something', argument: 3)
    Activity.count.should eq(3) # Because we are tracking user creation also
  end

  it 'should be able to track Friendship creation' do
    Friendship.create(user_id: @user.id, friend_id: @friend.id)
    Friendship.count.should eq(1)
    Activity.count.should eq(3)
  end

  it 'should be able to track user creation' do
    Activity.count.should eq(2)
  end

  it 'should be able to track event creation' do
    Event.create(
      title: 'Pub', description: 'pub with the ladz',
      user_id: 1, time_of_event: '1238219381')
    Activity.count.should eq(3)
  end

  it 'should belong to a user' do
    activitiy = Activity.reflect_on_association(:user)
    activitiy.macro.should == :belongs_to
  end

  it 'should be dependant destroy' do
    @user.activities.count.should eq(1)
    @user.destroy
    @user.activities.count.should eq(0)
  end
end
