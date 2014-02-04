# Friends Class
class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  before_save :check_for_duplicates?


  def check_for_duplicates?(find_options = {})
    if Friendship.where(find_options, conditions: ['user_id = ? and friend_id = ?', self.user_id, self.friend_id]).any?
      raise 'Duplicate'
    end
  end
end
