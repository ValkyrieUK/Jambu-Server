# OwnedEventsController
module Api
  # OwnedEventsController
  module V1
    # OwnedEventsController
    class OwnedEventsController < ApplicationController

      def show
        user = User.find_by(uid: params[:id])
        return unless user
        events = Event.where(user_id: user.id).order('created_at DESC').limit(50)
        render json: { events: events}
      end
    end
  end
end