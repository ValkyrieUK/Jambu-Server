require 'spec_helper'

describe 'DeviceToken API' , type: :api do
  before(:each) do
    @user = User.create(
      provider: 'twitter', username: 'BillyBob',
      image_url: 'http://...', image_thumbnail: 'http:..',
      full_name: 'Bill Bob', uid: '1234', colour: 'blue')
    end

  xit 'should be able to create a token' do
    post 'api/v1/device_tokens', device_token: {
      os: 'iOS', token: 'fhjaksdhfka', user_id: 1}
    response.status.should be(200)
  end
end
