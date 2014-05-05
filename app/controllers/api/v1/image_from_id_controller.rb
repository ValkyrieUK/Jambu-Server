# API Friendships controller
module Api
  # API Friendships controller
  module V1
    # API Friendships controller
    class ImageFromIdController < ApplicationController
      respond_to :json

      def show
        user = User.find_by(id: params[:id])
        render json: { url: user.image_url }
      end

    end
  end
end