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
        respond_with friendships: User.find(params[:id]).friends
      end

      def create
        respond_with Friendship.new(friendship_params).save, location: nil
      end

      def destroy
        respond_with Friendship.find(parmas[:friend_id]).delete
      end

      private

      def friendship_params
        params.require(:friendship).permit(:user_id, :friend_id)
      end
    end
  end
end
