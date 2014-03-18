require 'spec_helper'

describe Event do
  before(:each) do
    @user = FactoryGirl.build(:user)
  end

  it 'should be able to create a event' do
    @event = Event.create(
      title: 'Pub', description: 'pub with the ladz',
      user_id: 1, time_of_event: '1238219381')
    @event.save.should be true
  end

  it 'should be able to destroy an event' do
    event = Event.create(
      title: 'Pub', description: 'pub with the ladz',
      user_id: 1, time_of_event: '1238219381')
    Event.count.should eq(1)
    event.destroy
    Event.count.should eq(0)
  end

  it 'should be able to update a event' do
    Event.create(
    title: 'Pub', description: 'pub with the ladz',
    user_id: 1, time_of_event: '1238219381')
    Event.last.update(title: 'not the pub')
    Event.last.title.should eq('not the pub')
  end

  it 'should reject a event without a user id' do
    @event = Event.create(
      title: 'Pub', description: 'pub with the ladz',
      user_id: nil)
    @event.save.should be false
  end

  it 'should reject a event without a title' do
    @event = Event.create(
      title: nil, description: 'pub with the ladz',
      user_id: "#{@user.id}")
    @event.save.should be false
  end

  it 'should reject a event without a title' do
    @event = Event.create(
      title: 'Pub', description: nil,
      user_id: @user.id)
    @event.save.should be false
  end

  it 'should belong to a user' do
    event = Event.reflect_on_association(:user)
    event.macro.should == :belongs_to
  end

  it 'should have many attendess' do
    event = Event.reflect_on_association(:attendees)
    event.macro.should == :has_many
  end

  it 'should be dependant destroy' do
    @user = User.create(
      provider: 'twitter',
      username: 'asadada',
      image_url: 'http://...',
      image_thumbnail: 'http:..',
      full_name: 'Bill Bsadaob',
      uid: '1231123',
      colour: 'blue')
    @event = Event.create(
      title: 'Pub', description: 'pub with the ladz',
      user_id: @user.id, time_of_event: '1238219381')
    Event.count.should eq(1)
    @user.destroy
    Event.count.should eq(0)
  end
end
