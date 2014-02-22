# API Attendees controller
module Api
  # API Attendees controller
  module V1
    # API Attendees controller
    class AttendeesController < ApplicationController
      respond_to :json

      def index
        respond_with 'Please provide something...'
      end

      def show
        respond_with attendees: Event.find(parmas[:id]).attending_users
      end

      def create
        respond_with Attendee.new(attendee_params).save, location: nil
      end

      def update
        attendee = Attendee.find([:id])
        respond_with attendee.update(attendee_params)
      end

      def destroy
        respond_with Attendee.find([:id]).destroy
      end

      def attendee_params
        params.require(:attendee).permit(:event_id, :user_id, :time_of_event)
      end
    end
  end
end
