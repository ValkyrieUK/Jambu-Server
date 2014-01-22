module Api
  module V1
    class UsersController < ApplicationController
      respond_to :json
      
      def index
        respond_with User.all
      end

      def show
        respond_with User.search(params[:username])
      end

      def create
        respond_with User.new(user_params).save!
      end

      def destroy
        respond_with User.destroy(params[:id])
      end
      
      private

      def user_params
        params.require(:user).permit(:username, :uid, :provider, :image_url)
      end

    end
  end
end