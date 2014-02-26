# API Friendships controller
module Api
  # API Friendships controller
  module V1
    # API Friendships controller
    class FriendshipsController < ApplicationController
      respond_to :json

      def index
        respond_with 'Provide a User ID'
      end

      def show
        hash = { friendships: User.find(params[:id]).friends,
                 friendshipids: User.find(params[:id]).friendships }
        respond_with hash
      end

      def create
        respond_with Friendship.new(friendship_params).save, location: nil
        friend = User.find(friendship_params['friend_id'])
        user = User.find(friendship_params['user_id'])
        APNS.send_notification(friend.device_token,  "#{user.full_name} is now following you!") unless friend.device_token == 'NONE'
      end

      def destroy
        friendship = Friendship.find(params[:id])
        respond_with friendship.delete
        Activity.where(user_id: friendship.user_id, friend_id: friendship.friend_id,
          action: 'friend added').last.destroy
      end

      private

      def friendship_params
        params.require(:friendship).permit(:user_id, :friend_id)
      end
    end
  end
end
