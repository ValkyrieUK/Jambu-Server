# User Class
class User < ActiveRecord::Base
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  validates :provider, :uid, :username, :image_url, :full_name, :colour, presence: true
  validates :uid, uniqueness: true
  validates :provider, format: /\A(twitter)\Z/

  def self.search(search, find_options = {})
    if search
      self.where('username iLIKE ?', "%#{search}%").load
    end
  end
end
