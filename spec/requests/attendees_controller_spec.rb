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
    Attendee.create(event_id: @event.id, user_id: @friend.id, going?: false)
    Attendee.count.should eq(1)
  end

  it 'should not be able to find attendees that are not going to events' do
    @event.attendees.where(going?: false).count.should eq(1)
  end

  it 'should be able to change a users going status to true' do
    @attendee.update(going?: true)
    @attendee.save.should be true
  end

end
