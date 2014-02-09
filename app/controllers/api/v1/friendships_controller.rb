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
        # User.find(params[:id]).friends
        hash = { friendships: User.find(params[:id]).friends,
                 friendshipids: User.find(params[:id]).friendships }
        respond_with hash
      end

      def create
        respond_with Friendship.new(friendship_params).save, location: nil
      end

      def destroy
        respond_with Friendship.find(params[:id]).delete
      end

      private

      def friendship_params
        params.require(:friendship).permit(:user_id, :friend_id)
      end
    end
  end
end
