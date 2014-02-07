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
    response.status.should be(200)
  end

  it 'should be able to create a new user and save them via the API' do
    post 'api/v1/users', user: {
     uid: '4321', username: 'Mike123',
     full_name: 'Michael Scofield', image_url: 'http://...',
     provider: 'twitter', image_thumnail: 'http://...',
     colour: 'blue'}
    response.status.should be(201)
  end

  it 'should be able to update a user' do
    user = FactoryGirl.create(:user)
    put "api/v1/users/#{user.id}", user: { username: 'JohnDoe' }
    response.status.should be(204)
    get "api/v1/users/#{user.uid}"
    expect(json['username']).to eq('JohnDoe')
    response.status.should be(200)
  end

  it 'should be able to delete users' do
    user = FactoryGirl.create(:user)
    delete "api/v1/users/#{user.uid}"
    response.status.should be(204)
    User.count.should eq(0)
  end
end
