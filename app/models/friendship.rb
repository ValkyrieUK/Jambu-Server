# Friends Class
class Friendship < ActiveRecord::Base
  after_create :notification
  after_save :track

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, :friend_id, presence: true
  validates :user_id, uniqueness: { scope: :friend_id }

  def track
    friend = User.find(friend_id)
    Activity.create(user_id: user_id, action: 'friend added',
                    name: friend.full_name, argument: friend.uid,
                    friend_id: friend.id)
  end

  def notification
    user = User.find(user_id)
    friend = User.find(friend_id)
    friend.device_tokens.each do |e|
      if e.os == 'iOS'
        APNS.send_notification(e.token, "#{user.full_name} is now following you!", :sound => 'default', :other => {:p => 'foll', :pid => user.uid}) unless e.token == 'NONE' || e.token.nil?
      else
        gcm ||= GCM.new(Rails.application.config.gcm_key)
        message = { data: { message: "#{user.full_name} is now following you!" } }
        gcm.send_notification(e.token, message) unless e.token == 'NONE' || e.token.nil?
      end
    end
  end
end
