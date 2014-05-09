# NearbyEventsController
module Api
  # NearbyEventsController
  module V1
    # NearbyEventsController
    class NearbyEventsController < ApplicationController
      respond_to :json
      def nearby
        render json: { events: Event.near([params[:lat], params[:long]], params[:distance]).where(privacy: 'public', canceled: 'false') }
      end
    end
  end
end
