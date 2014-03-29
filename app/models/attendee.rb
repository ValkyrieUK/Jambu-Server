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
    gcm ||= GCM.new(Rails.application.config.gcm_key)
    attendee.device_tokens.each do |e|
      if e.os == 'iOS'
        APNS.delay.send_notification(e.token, "#{owner.full_name} invited you to #{event.title}!") unless e.token == 'NONE' || e.token.nil?
      else
        message = { data: { message: "#{owner.full_name} invited you to #{event.title}!" } }
        gcm.delay.send_notification(i.token, message) unless e.token == 'NONE' || e.token.nil?
      end
    end
  end

  def track
    return unless going? == true
    Activity.delay.create(user_id: user_id, action: 'joined event', argument: event_id)
  end

  def make_nil
    self.going? == nil
  end
end
