# API Feed controller
module Api
  # API Feed controller
  module V1
    # API Feed controller
    class FollowersController < ApplicationController
      respond_to :json
      def show
        user = User.find_by_uid(params[:id])
        render json: { followers: user.inverse_friends }
      end
    end
  end
end
