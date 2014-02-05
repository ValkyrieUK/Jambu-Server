class Event < ActiveRecord::Base
  has_many :attendees
  has_many :inverse_attendee, class_name: 'Attendee', foreign_key: 'user_id'
  validates :title, :description, :user_id, presence: true
end
