# DeviceToken class
class DeviceToken < ActiveRecord::Base
  belongs_to :user

  validates :token, :os, :user_id, presence: true
  validates :user_id, uniqueness: { scope: :token }
end
