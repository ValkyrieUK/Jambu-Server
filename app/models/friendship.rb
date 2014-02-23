# Friends Class
class Friendship < ActiveRecord::Base
  before_save :track, on: :create

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, :friend_id, presence: true
  validates :user_id, uniqueness: { scope: :friend_id }

  def track
    Activity.create(user_id: user_id, action: 'friend added', argument: friend_id)
  end
end
