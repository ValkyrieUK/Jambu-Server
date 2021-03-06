# API Friendships controller
module Api
  # API Friendships controller
  module V1
    # API Friendships controller
    class FriendshipsController < ApiController
      respond_to :json

      def show
        hash = { friendships: User.find(params[:id]).friends }
        respond_with hash
      end

      def create
        friendship = Friendship.new(friendship_params)
        if friendship.save
          render json: { success: true }
        else
          render json: { errors: friendship.errors.full_messages }
        end
      end

      def destroy
        friendship = Friendship.find(params[:id])
        if friendship.delete
          respond_with friendship
          Activity.where(user_id: friendship.user_id, friend_id: friendship.friend_id,
                         action: 'friend added').last.destroy
        end
      end

      private

      def friendship_params
        params.require(:friendship).permit(:user_id, :friend_id)
      end
    end
  end
end
