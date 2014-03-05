require 'spec_helper'

describe DeviceToken do

  it 'should not create a token if the parameters are not present' do
    DeviceToken.create(os: nil, token: nil, user_id: nil)
  end

  it 'should not execpt blank strings' do
    DeviceToken.create(os: '', token: '', user_id: '')
  end

  xit 'should not save a token that alread'
end
