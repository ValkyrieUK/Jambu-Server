# Attendee Model
class Attendee < ActiveRecord::Base
  after_create :ios_notification

  belongs_to :user
  belongs_to :event
  validates :event_id, :user_id, presence: true
  validates :event_id, uniqueness: { scope: :user_id }

  def ios_notification
    attendee = User.find(user_id)
    event = Event.find(event_id)
    owner = User.find(event.user_id)
    return if attendee.device_token == 'NONE' || attendee.device_token == nil
    APNS.send_notification(attendee.device_token, "#{owner.full_name} invited you to #{event.title}!")
  end
end
