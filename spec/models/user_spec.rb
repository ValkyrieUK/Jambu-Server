require 'spec_helper'

describe User do
  before(:each) do
    @user = User.create(
              provider: 'twitter',
              username: 'BillyBob',
              image_url: 'http://...',
              full_name: 'Bill Bob',
              uid: '1234')
  end

  it 'Should save a user with valid params' do
    @user.save.should == true
  end

  it 'should reject a user without a provider' do
    @user.provider = nil
    @user.save.should == false
  end

  it 'should reject a user without a username' do
    @user.username = nil
    @user.save.should == false
  end

  it 'should reject a user without a image_url' do
    @user.image_url = nil
    @user.save.should == false
  end

  it 'should reject a user witout a uid' do
    @user.uid = nil
    @user.save.should == false
  end

  it 'should reject a user with a duplicate uid' do
    @duplicate_user = User.create(
              provider: 'twitter',
              username: 'BillyBob',
              image_url: 'http://...',
              full_name: 'Bill Bob',
              uid: '1234')
    @duplicate_user.save.should == false
  end

end
