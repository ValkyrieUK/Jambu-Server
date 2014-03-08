require 'spec_helper'

describe DeviceToken do
  before(:each) do
    @user = User.create(
      provider: 'twitter', username: 'BillyBob',
      image_url: 'http://...', image_thumbnail: 'http:..',
      full_name: 'Bill Bob', uid: '1234', colour: 'blue')
    end

  it 'should not create a token if the parameters are not present' do
    DeviceToken.create(os: nil, token: nil, user_id: nil)
  end

  it 'should not execpt blank strings' do
    DeviceToken.create(os: '', token: '', user_id: '')
  end

  it 'should have a os' do
    token = DeviceToken.create(os: nil, token: 'iffhnrjeufbf', user_id: '@user.id')
    token.save.should be false
  end

  it 'should have a token' do
    token = DeviceToken.create(os: 'iOS', token: nil, user_id: '@user.id')
    token.save.should be false
  end

  it 'should have a user' do
    token = DeviceToken.create(os: 'iOS', token: 'sdfsdfsfwfe', user_id: nil)
    token.save.should be false
  end

  it 'should not save a token that already exists' do
    DeviceToken.create(os: 'iOS', token: 'hghghghghg', user_id: @user.id)
    token = DeviceToken.create(os: 'iOS', token: 'hghghghghg', user_id: @user.id)
    token.save.should be false
  end

  it 'should save a token that does not exist for a user' do
    DeviceToken.create(os: 'iOS', token: 'hghghghghg', user_id: @user.id)
    token = DeviceToken.create(os: 'iOS', token: 'oqoqoqo', user_id: @user.id)
    token.save.should be true
  end
end
