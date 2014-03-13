require 'spec_helper'

describe User do
  before(:each) do
    @user = FactoryGirl.build(:user)
  end

  it 'Should save a user with valid params' do
    @user.save.should be true
  end

  it 'should reject a user without a provider' do
    @user.provider = nil
    @user.save.should be false
  end

  it 'should reject a user without a username' do
    @user.username = nil
    @user.save.should be false
  end

  it 'should reject a user without a image_url' do
    @user.image_url = nil
    @user.save.should be false
  end

  it 'should reject a user without a full_name' do
    @user.full_name = nil
    @user.save.should be false
  end

  it 'should reject a user witout a uid' do
    @user.uid = nil
    @user.save.should be false
  end

  it 'should reject a user with a duplicate uid' do
    @user.save
    @duplicate_user = User.create(
      provider: 'twitter',
      username: 'BillyBob',
      image_url: 'http://...',
      image_thumbnail: 'http:..',
      full_name: 'Bill Bob',
      uid: '1234',
      colour: 'blue')
    @duplicate_user.save.should be false
  end

  it 'should ony have twitter as a provider' do
    @user.provider = 'facebook'
    @user.save.should be false
  end

  it 'should reject a user with a username longer than 35 characters' do
    @user.username = 'b' * 36
    @user.save.should be false
    @user2  = User.create(
      provider: 'twitter',
      username: 'asadada',
      image_url: 'http://...',
      image_thumbnail: 'http:..',
      full_name: 'Bill Bsadaob',
      uid: '1231123',
      colour: 'blue')
    @user2.username = 'b' * 35
    @user2.save.should be true
  end

  it 'should reject a user with a full_name longer than 35 characters' do
    @user.full_name = 'b' * 36
    @user.save.should be false
    @user2  = User.create(
      provider: 'twitter',
      username: 'asadada',
      image_url: 'http://...',
      image_thumbnail: 'http:..',
      full_name: 'Bill Bsadaob',
      uid: '1231123',
      colour: 'blue')
    @user2.full_name = 'b' * 35
    @user2.save.should be true
  end

  it 'should reject a user with a colour longer than 35 characters' do
    @user.colour = 'b' * 36
    @user.save.should be false
    @user2  = User.create(
      provider: 'twitter',
      username: 'asadada',
      image_url: 'http://...',
      image_thumbnail: 'http:..',
      full_name: 'Bill Bsadaob',
      uid: '1231123',
      colour: 'blue')
    @user2.colour = 'b' * 35
    @user2.save.should be true
  end

  it 'should be able to update a user' do
    @user.update(username: 'HeyLookImUpdated')
    @user.username.should eq('HeyLookImUpdated')
  end

  it 'should be able to search for a user' do
    @user.save
    search = User.search(@user.username)
    search.should eq(search)
  end

  it 'should have many device tokens' do
    token = User.reflect_on_association(:device_tokens)
    token.macro.should == :has_many
  end

  it 'should have many activities' do
    activity = User.reflect_on_association(:activities)
    activity.macro.should == :has_many
  end

  it 'should have many activities' do
    event = User.reflect_on_association(:events)
    event.macro.should == :has_many
  end

  it 'should have many friendships' do
    friendship = User.reflect_on_association(:friendships)
    friendship.macro.should == :has_many
  end

  it 'should have many friends' do
    friendship = User.reflect_on_association(:friends)
    friendship.macro.should == :has_many
  end
end
