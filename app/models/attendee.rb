class Attendee < ActiveRecord::Base
  belongs_to :event
  has_many :inverse_attendees, class_name: 'Attendee', foreign_key: 'user_id'
end
