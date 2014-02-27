require 'spec_helper'

describe Attendee do
  before(:each) do
    @event = Event.create(
      title: 'Pub', description: 'pub with the ladz',
      user_id: 1, time_of_event: '1238219381')
    @user = User.create(
      provider: 'twitter', username: 'BillyBob',
      image_url: 'http://...', image_thumbnail: 'http:..',
      full_name: 'Bill Bob', uid: '1234', colour: 'blue')
  end

  it 'should be able to create an attendee' do
    @attending_user = Attendee.create(
      event_id: "#{@event.id}", user_id: "#{@user.id}")
    @event.save.should be true
    Attendee.count.should eq(1)
  end

  it 'should not create dupliacte attendees' do
    Attendee.create(
      event_id: "#{@event.id}", user_id: "#{@user.id}")
    attending_user2 = Attendee.create(
      event_id: "#{@event.id}", user_id: "#{@user.id}")
    attending_user2.save.should be false
  end

  it 'should be able to destroy an attendee' do
    attending_user = Attendee.create(event_id: "#{@event.id}", user_id: "#{@user.id}")
    Attendee.count.should eq(1)
    attending_user.destroy
    Attendee.count.should eq(0)
  end
end
