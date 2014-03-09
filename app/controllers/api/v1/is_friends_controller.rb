# API Users controller
module Api
# API Users controller
  module V1
    # API Users controller
    class IsFriendsController < ApplicationController
      respond_to :json

      def show
        puts params
        response = Friendship.where(user_id: (params[:id]), friend_id: (params[:user])).any?
        render json: { friends?: response }
      end

    end
  end
end
