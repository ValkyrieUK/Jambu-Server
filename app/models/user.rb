class User < ActiveRecord::Base
 has_many :friendships
 has_many :friends, through: :friendships

 validates_presence_of :provider, :uid, :username, :image_url, :full_name
end
