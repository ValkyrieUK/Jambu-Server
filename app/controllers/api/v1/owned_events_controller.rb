# OwnedEventsController
module Api
  # OwnedEventsController
  module V1
    # OwnedEventsController
    class OwnedEventsController < ApplicationController

      def show
        user = User.find_by(uid: params[:id])
        return unless user
        events = Event.where(user_id: user.id)
        render json: { events: events}
      end
    end
  end
end