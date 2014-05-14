# API Feed controller
module Api
  # API Feed controller
  module V1
    # API Feed controller
    class FeedController < ApiController
      respond_to :json

      def show
        user = User.find_by_uid(params[:id])
        respond_with feed: user.activities.reverse.take(20)
      end
    end
  end
end
