# User Class
class User < ActiveRecord::Base
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

    future_time = Time.now.to_f + 3.seconds
    future_time2 = Time.now.to_f + 5.seconds
    # future_time3 = Time.now.to_i + 7.seconds
  loop do
    puts "THE TIME is #{future_time}" if Time.now.to_f == future_time
    puts "THE TIME is #{future_time2}" if Time.now.to_f == future_time2
  end

  # loop do
  # end    # puts "THE TIME is #{future_time3}" if Time.now.to_f == future_time3
end