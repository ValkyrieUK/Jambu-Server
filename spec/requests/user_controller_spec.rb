require 'spec_helper'

describe 'Users API' , type: :api do

  it 'should return a array of users' do
    get '/api/v1/users'
    response.status.should be(200)
  end

  it 'should return a valid user with the correct details' do
    user = FactoryGirl.create(:user)
    get "api/v1/users/#{user.uid}"
    expect(response).to be_success
    expect(json['uid']).to eq(user.uid)
    expect(json['username']).to eq(user.username)
    expect(json['full_name']).to eq(user.full_name)
    expect(json['image_url']).to eq(user.image_url)
    expect(json['provider']).to eq(user.provider)
  end
end
