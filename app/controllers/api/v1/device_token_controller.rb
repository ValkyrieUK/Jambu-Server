# DeviceTokenController
module Api
  # DeviceTokenController
  module V1
    # DeviceTokenController
    class DeviceTokensController < ApplicationController
      respond_to :json

      def create
        token = DeviceToken.new(token_params)
        if token.save
          respond_with token, location: nil
        else
          render json: { errors: token.errors.full_messages }
        end
      end

      def token_params
        params.require(:device_token).permit(:user_id, :os, :token)
      end
    end
  end
end
