# API Users controller
module Api
# API Users controller
  module V1
    # API Users controller
    class UsersController < ApplicationController
      respond_to :json

      def index
        respond_with users: User.all
      end

      def show
        respond_with User.find_by_uid(params[:uid])
      end

      def create
        respond_with User.new(user_params).save, location: nil
      end

      def update
        user = User.find(params[:id])
        respond_with user.update(user_params)
      end

      def destroy
        respond_with User.find_by(params[:uid]).destroy
      end

      private

      def user_params
        params.require(:user).permit(:username, :uid, :provider, :image_url, :image_thumbnail, :full_name, :colour)
      end
    end
  end
end
