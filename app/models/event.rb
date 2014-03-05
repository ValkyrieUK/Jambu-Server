# Event Model
class Event < ActiveRecord::Base
  after_create :track
  after_initialize :nullify_time
  after_save :alert_attendees, on: :update

  belongs_to :user

  has_many :attendees, dependent: :destroy
  has_many :users
  has_many :attending_users, through: :attendees, source: :user
  has_many :inverse_atteding_users, class_name: 'Attendee', foreign_key: 'user_id'

  validates :title, :user_id, presence: true
  validates :title, uniqueness: { scope: :user_id }

  def nullify_time
    self.time_of_event  ||= 'none'
  end

  def track
    Activity.create(user_id: user_id, action: 'event created', name: title)
  end

  def alert_attendees
    self.attending_users.each do |e|
      e.device_tokens.each do |i|
        APNS.send_notification(i.token, "#{self.title} has been updated, Check the event to find out more!") unless self.time_of_event == 'in progress or over' || i.token.nil? || i.token == 'NONE' || i.os == 'android'
      end
    end
  end
end
