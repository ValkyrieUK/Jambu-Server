require 'spec_helper'

describe 'Attendee API' , type: :api do

  before(:each) do
    @user = User.create(
      provider: 'twitter', username: 'BillyBob',
      image_url: 'http://...', image_thumbnail: 'http:..',
      full_name: 'Bill Bob', uid: '12134', colour: 'blue',
      device_token: 'NONE')
    @event = Event.create(
      title: 'Pub', description: 'pub with the ladz',
      user_id: @user.id, time_of_event: '1238219381')
    @friend = User.create(
      provider: 'twitter', username: 'Jimmy',
      image_url: 'http://...', image_thumbnail: 'http:..',
      full_name: 'Billdsf Bob', uid: '92811',
      colour: 'blue', device_token: 'NONE')
    @attendee = Attendee.create(
      event_id: @event.id, user_id: @friend.id, going?: false)
  end

  it 'should be able to create a attendee to a event' do
    post 'api/v1/attendees', attendee: {
      event_id: @event.id, user_id: @friend.id, going?: false }
    Attendee.count.should eq(1)
  end

  it 'should not be able to find attendees that are going to events' do
    get "api/v1/attendees/#{@event.id}"
    response.status.should be(200)
    expect(response).to be_success
    expect(json['attendees'].first['uid']).to eq(@friend.uid)
    expect(json['attendees'].first['username']).to eq(@friend.username)
    expect(json['attendees'].first['username']).to eq(@friend.username)
    expect(json['attendees'].first['full_name']).to eq(@friend.full_name)
    expect(json['attendees'].first['image_url']).to eq(@friend.image_url)
    expect(json['attendees'].first['provider']).to eq(@friend.provider)
  end

  it 'should be able to update a attendee' do
    @attendee.going?.should eq(false)
    put "api/v1/attendees/#{@attendee.id}", attendee: { going?: true }
    response.status.should be(204)
    get "api/v1/attendees/#{@event.id}"
    Attendee.find(@attendee.id).going?.should be true
  end

  it 'should be able to destroy a attendee' do
    delete "api/v1/attendees/#{@attendee.id}"
    response.status.should be(204)
    Attendee.count.should eq(0)
  end

end
