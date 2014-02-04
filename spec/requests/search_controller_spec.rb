require 'spec_helper'

describe 'Search API' , type: :api do

  it 'should return a valid search result' do
    user = FactoryGirl.create(:user)
    get "api/v1/search/#{user.username[0..5]}"
    expect(response).to be_success
    expect(json['users'].first['uid']).to eq(user.uid)
    expect(json['users'].first['username']).to eq(user.username)
    expect(json['users'].first['full_name']).to eq(user.full_name)
    expect(json['users'].first['image_url']).to eq(user.image_url)
    expect(json['users'].first['provider']).to eq(user.provider)
    response.status.should be(200)
  end


end