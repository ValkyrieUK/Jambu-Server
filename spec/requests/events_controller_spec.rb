require 'spec_helper'

describe 'Events API' , type: :api do

  before(:each) do
    @event = Event.create(
      title: 'Pub', description: 'pub with the ladz',
      user_id: 1, time_of_event: '1238219381')
  end

  it 'should return a event' do
    get "api/v1/events/#{@event.id}"
    response.status.should be(200)
    expect(json['title']).to eq('Pub')
    expect(json['description']).to eq('pub with the ladz')
    expect(json['user_id']).to eq(1)
  end

  it 'should be able to create events via the api' do
    Event.destroy_all
    post 'api/v1/events', event: {
      title: 'Pub', description: 'pub with the ladz',
      user_id: 1, time_of_event: '1238219381' }
    response.status.should be(200)
    Event.count.should be 1
  end

  it 'should be able to update a event' do
    put "api/v1/events/#{@event.id}", event: { title: 'Park' }
    response.status.should be(204)
    get "api/v1/events/#{@event.id}"
    expect(json['title']).to eq('Park')
    response.status.should be(200)
    Event.count.should be 1
  end

  it 'should be able to cancel events via the api' do
    put "api/v1/events/#{@event.id}", event: { canceled?: true }
    response.status.should be(204)
    Event.find(@event.id).canceled?.should eq('true')
  end
end
