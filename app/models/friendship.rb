# Friends Class
class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  before_save :check_for_duplicates?
  validates :user_id, :friend_id, presence: true

  def check_for_duplicates?
    return if Friendship.all(conditions: ['user_id = ? and friend_id = ?', user_id, friend_id]).any?
  end
end
