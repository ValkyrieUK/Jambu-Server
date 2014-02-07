class Attendee < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  validates :event_id, :user_id, presence: true
  validates_uniqueness_of :event_id, scope: [:user_id]
end
