# API Feed controller
module Api
  # API Feed controller
  module V1
    # API Feed controller
    class FollowersController < ApplicationController
      respond_to :json
      def show
        user = User.find_by_uid(params[:id])
        render json: { followers: User.joins(:friendships).merge(Friendship.where(friend_id: user.id)) }
      end
    end
  end
end
