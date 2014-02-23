# Event Model
class Event < ActiveRecord::Base
  before_save :track, on: :create
  # before_save :track_update, on: :update

  belongs_to :user

  has_many :attendees
  has_many :users
  has_many :attending_users, through: :attendees, source: :user
  has_many :inverse_atteding_users, class_name: 'Attendee', foreign_key: 'user_id'

  validates :title, :user_id, presence: true

  def track
    Activity.create(user_id: user_id, action: 'event created', argument: title)
  end

  def track_update
    Activity.create(user_id: user_id, action: 'event updated', argument: title)
  end
end
