module Api
  module V1
    class UsersController < ApplicationController
      respond_to :json

      def index
        respond_with  User.all
      end

      def show
        respond_with User.find_by_username(params[:username])
      end

      # Not so sure about save here..
      def create
         user = User.new(user_params)
        if user.save 
          puts '*****************'
        else
          puts '@@@@@@@@@@@@@@@@@@@@@@@@@@@'
        end
      end

      def update 
        respond_with User.update(params[:id], user_params).save
      end

      def destroy
        respond_with User.destroy(params[:id])
      end

      def success
        respond_with '*************************************'
      end

      private

      def user_params
        params.require(:user).permit(:username, :uid, :provider, :image_url, :full_name)
      end
    end
  end
end