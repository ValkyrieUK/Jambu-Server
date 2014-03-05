class DeviceToken < ActiveRecord::Base
  belongs_to :user

  validates :user_id, uniqueness: { scope: :token }
end
