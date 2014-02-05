class Event < ActiveRecord::Base
  has_many :attendees
  has_many :users
  has_many :attending_users, :through => :attendees, :source => :user
  has_many :inverse_atteding_users, class_name: 'Attendee', foreign_key: 'user_id'

  validates :title, :description, :user_id, presence: true
end
