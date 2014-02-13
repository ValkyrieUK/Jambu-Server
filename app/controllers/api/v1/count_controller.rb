# API Events controller
module Api
  # API Events controller
  module V1
    # API Events controller
    class CountController < ApplicationController
      respond_to :json

      def show
        respond_with friends: User.find_by_uid(params[:id]).friends.count
      end

    end
  end
end