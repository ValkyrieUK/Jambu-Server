# User Class
class User < ActiveRecord::Base
  after_create :track

  has_many :device_tokens, dependent: :destroy
  has_many :device_tokens, class_name: 'DeviceToken', foreign_key: 'user_id'
  has_many :activities, dependent: :destroy
  has_many :activities, class_name: 'Activity', foreign_key: 'user_id'
  has_many :events, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  validates :provider, :uid, :username, :image_url, :image_thumbnail, :full_name, :colour, presence: true
  validates :uid, uniqueness: true
  validates :provider, format: /\A(twitter)\Z/
  validates :username, :full_name, :colour, length: { maximum: 35 }

  def self.search(search, find_options = {})
    where('username iLIKE ? or full_name iLIKE ?', "%#{search}%", "%#{search}%") if search
  end


  def attending_events_future
    Event.joins(:attending_users).where("time_of_event > ?", Time.now.to_i.to_s).merge(Attendee.where(user_id: self, going?: true))
  end

  def attending_events_past
      Event.joins(:attending_users).where("time_of_event < ?", Time.now.to_i.to_s).merge(Attendee.where(user_id: self, going?: true))
  end

  def attending_events
    Event.joins(:attending_users).merge(Attendee.where(user_id: self, going?: true))
  end

  def pending_invites
      Event.joins(:attending_users).where(canceled: 'true').merge(Attendee.where(user_id: self, going?: nil))
  end

  def none?
    device_token == 'NONE'
  end

  def track
    Activity.create(user_id: id, action: 'user created')
  end
end
