# Attendee Model
class Attendee < ActiveRecord::Base
  after_create :notification
  after_save :track
  after_initialize :make_nil

  belongs_to :user
  belongs_to :event
  validates :event_id, :user_id, presence: true
  validates :event_id, uniqueness: { scope: :user_id }

  def notification
    attendee = User.find(user_id)
    event = Event.find(event_id)
    owner = User.find(event.user_id)
    send_notification(attendee, event, owner)
  end

  def send_notification(attendee, event, owner)
    return unless attendee && event && owner
    attendee.device_tokens.each do |e|
      if e.os == 'iOS'
        APNS.send_notification(e.token, alert: "#{owner.full_name} invited you to #{event.title}!", badge: 1, sound: 'default', other: { p: 'invite', pid: event.id.to_s }) unless e.token == 'NONE' || e.token.nil?
      else
        gcm ||= GCM.new(Rails.application.config.gcm_key)
        message = { data: { message: "#{owner.full_name} invited you to #{event.title}!" } }
        gcm.send_notification(e.token, message) unless e.token == 'NONE' || e.token.nil?
      end
    end
  end

  def track
    return unless going? == true
    Activity.create(user_id: user_id, action: 'joined event', argument: event_id)
  end

  def make_nil
    self.going? == nil
  end
end
