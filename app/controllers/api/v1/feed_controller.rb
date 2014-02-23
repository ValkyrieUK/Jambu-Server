# API Feed controller
module Api
  # API Feed controller
  module V1
    # API Feed controller
    class FeedController < ApplicationController
      respond_to :json

      def show
        user = User.find_by_uid(params[:id])
        respond_with feed: user.activities.reverse.limit(20)
      end

    end
  end  
end
