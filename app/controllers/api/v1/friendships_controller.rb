module Api
  module V1
    class FriendshipsController < ApplicationController
      respond_to :json

      def index
        respond_with 'Please include a user ID'
      end

      def show
        respond_with User.find(params[:id]).friends
      end

      def create

      end

      def destroy
        respond_with User.find(params[:id]).friendships.find(params[:name])
      end

    end
  end
end