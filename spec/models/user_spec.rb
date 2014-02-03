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
              full_name: 'Bill Bob',
              uid: '1234')
    @duplicate_user.save.should be false
  end

  it 'should ony have twitter as a provider' do
    @user.provider = 'facebook'
    @user.save.should be false
  end

end
