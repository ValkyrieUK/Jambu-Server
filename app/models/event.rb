# Event Model
class Event < ActiveRecord::Base
  reverse_geocoded_by :lat, :long
  after_create :track, :create_owner_attendee
  after_initialize :nullify_time, :nullify_notified
  after_save :alert_attendees, on: :update

  belongs_to :user

  has_many :attendees, dependent: :destroy
  has_many :users
  has_many :invited_users, through: :attendees, source: :user
  has_many :inverse_atteding_users, class_name: 'Attendee', foreign_key: 'user_id'

  validates :title, :user_id, presence: true

  def nullify_time
    self.time_of_event  ||= 'none'
  end

  def nullify_notified
    self.notified  ||= false
  end

  def track
    Activity.create(user_id: user_id, action: 'event created', name: title, argument: id)
  end

  def attending_users
    attendees.where(going?: true).map { |attendee| User.find(attendee.user_id) }
  end

  def create_owner_attendee
    Attendee.create(user_id: user_id, event_id: id, going?: true)
  end

  def alert_attendees
    invited_users.each do |e|
      e.device_tokens.each do |i|
        if i.os == 'iOS'
          APNS.send_notification(
          i.token, alert: "#{title} has been updated, Check the event to find out more!", badge: 1, sound: 'default', other: { p: 'eventUp', pid: id.to_s }
          ) unless canceled == 'true' || i.token.nil? || i.token == 'NONE'
        else
          gcm ||= GCM.new(Rails.application.config.gcm_key)
          message = { data: { message: "#{title} has been updated, Check the event to find out more!" } }
          gcm.send_notification(i.token, message) unless i.token == 'NONE' || i.token.nil?
        end
      end
    end
  end
end
