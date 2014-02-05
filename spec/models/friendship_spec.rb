require 'spec_helper'

describe Friendship do

  it 'should create a friendship' do
    friendship = Friendship.create(user_id: 1, friend_id: 2)
    friendship.save.should be true
  end

  it 'should not create a friendship that already exits' do
    friendship = Friendship.create(user_id: 1, friend_id: 2)
    friendship.save.should be false
  end
end