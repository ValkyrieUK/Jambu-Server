require 'spec_helper'

describe 'Users API' , type: :api do

  before(:each) do
    @event = Event.create(
      title: 'Pub', description: 'pub with the ladz',
      user_id: 1, time_of_event: "1238219381")
  end

  it 'should be able to create events via the api' do
    Event.destroy_all
    post 'api/v1/events', event: {
      title: 'Pub', description: 'pub with the ladz',
      user_id: 1, time_of_event: "1238219381"}
    response.status.should be(201)
    Event.count.should be 1
  end

  it 'should be able to delete events via the api' do
    delete "api/v1/events/#{@event.id}"
    response.status.should be(204)
    Event.count.should eq(0)
  end
end