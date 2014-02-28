# Attendee Model
class Attendee < ActiveRecord::Base
  after_create :ios_notification
  after_save :track

  belongs_to :user
  belongs_to :event
  validates :event_id, :user_id, presence: true
  validates :event_id, uniqueness: { scope: :user_id }

  def ios_notification
    attendee = User.find(user_id)
    event = Event.find(event_id)
    owner = User.find(event.user_id)
    APNS.send_notification(attendee.device_token, "#{owner.full_name} invited you to #{event.title}!") unless attendee.device_token == 'NONE' || attendee.device_token.nil?
  end

  def track
    return unless going? == true
    Activity.create(user_id: user_id, action: 'joined event', argument: event_id)
  end
end
