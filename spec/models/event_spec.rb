require 'spec_helper'

describe Event do
  before(:each) do
    @user = FactoryGirl.build(:user)
  end

  it 'should be able to create a event' do
    @event = Event.create(title: 'Pub', description: 'pub with the ladz',
                          user_id: "#{@user.id}")
    @event.save.should be true
  end

  it 'should reject a event without a user id' do
    @event = Event.create(title: 'Pub', description: 'pub with the ladz',
                          user_id: nil)
    @event.save.should be false
  end

  it 'should reject a event without a title' do
    @event = Event.create(title: nil, description: 'pub with the ladz',
                          user_id: "#{@user.id}")
    @event.save.should be false
  end

  it 'should reject a event without a title' do
    @event = Event.create(title: 'Pub', description: nil,
                          user_id: "#{@user.id}")
    @event.save.should be false
  end
end
