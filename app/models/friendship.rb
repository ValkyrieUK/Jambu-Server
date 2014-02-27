# Friends Class
class Friendship < ActiveRecord::Base
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
end
