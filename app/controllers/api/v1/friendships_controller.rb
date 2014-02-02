# API Users controller
module Api
  # API Users controller
  module V1
    # API friendships controller
    class FriendshipsController < ApplicationController
      respond_to :json

      def index
        respond_with Friendship.all
      end

      def show
        respond_with User.find(params[:id]).friends
      end

      def create
        respond_with Friendship.new(friendship_params).save, location: nil
      end

      def destroy
        respond_with Friendship.find(params[:id])
      end

      private

      def friendship_params
        params.require(:friendship).permit(:user_id, :friend_id)
      end
    end
  end
end
