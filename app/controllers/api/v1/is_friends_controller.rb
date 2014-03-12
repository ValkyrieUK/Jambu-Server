# API Users controller
module Api
# API Users controller
  module V1
    # API Users controller
    class IsFriendsController < ApplicationController
      respond_to :json

      def show
        response = Friendship.where(user_id: (params[:id]), friend_id: (params[:user]))
        if response.any?
          render json: { friendship_id: response.last.id }
        else
          render json: { friendship_id: 'Not Friends' }
        end
      end
    end
  end
end
