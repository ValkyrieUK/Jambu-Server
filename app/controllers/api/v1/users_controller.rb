# API Users controller
module Api
# API Users controller
  module V1
    # API Users controller
    class UsersController < ApplicationController
      respond_to :json

      def index
        respond_with User.all
      end

      def show
        respond_with User.find_by_uid(params[:uid])
      end
      # Not so sure about save here..
      def create
        respond_with User.new(user_params).save, location: nil
      end

      def update
        respond_with User.find_by(params[:uid]).update(user_params)
      end

      def destroy
        respond_with User.find_by(params[:uid]).destroy
      end

      private

      def user_params
        params.require(:user).permit(:username, :uid, :provider, :image_url, :full_name, :color)
      end
    end
  end
end
