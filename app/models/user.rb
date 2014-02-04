# User Class
class User < ActiveRecord::Base
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  validates :provider, :uid, :username, :image_url, :image_thumbnail, :full_name, :colour, presence: true
  validates :uid, uniqueness: true
  validates :provider, format: /\A(twitter)\Z/

  def self.search(search, find_options = {})
    User.where('username iLIKE ?', "%#{search}%").load if search
  end
end
