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
        respond_with attendees: Event.find(params[:id]).attending_users
      end

      def create
        attendee = Attendee.new(attendee_params)
        if attendee.save
          respond_with attendee, location: nil
        else
          render json: { errors: attendee.errors.full_messages }
        end
      end

      def update
        attendee = Attendee.find(params[:id])
        user = User.find(user_id)
        event = Event.find(event_id)
        respond_with attendee.update(attendee_params)
        Activity.create(user_id: user.id, action: 'attendee updated', argument: event.id)
      end

      def destroy
        respond_with Attendee.find(params[:id]).destroy
      end

      def attendee_params
        params.require(:attendee).permit(:event_id, :user_id, :time_of_event, :going?)
      end
    end
  end
end
