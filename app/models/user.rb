# User Class
class User < ActiveRecord::Base
  has_many :friendships
  has_many :friends, through: :friendships

  validates :provider, :uid, :username, :image_url, :full_name, presence: true
  validates :uid, uniqueness: true
  validates :provider, format: /\A(twitter)\Z/
end
