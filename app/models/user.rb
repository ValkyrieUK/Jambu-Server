# User Class
class User < ActiveRecord::Base
  after_save :track

  has_many :activities
  has_many :activities, class_name: 'Activity', foreign_key: 'user_id'
  has_many :events
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  validates :provider, :uid, :username, :image_url, :image_thumbnail, :full_name, :colour, presence: true
  validates :uid, uniqueness: true
  validates :provider, format: /\A(twitter)\Z/
  validates :username, :full_name, :colour, length: { maximum: 35 }

  def self.search(search, find_options = {})
    User.where('username iLIKE ? or full_name iLIKE ?', "%#{search}%", "%#{search}%") if search
  end

  def track
    Activity.create(user_id: id, action: 'user created')
  end
end
