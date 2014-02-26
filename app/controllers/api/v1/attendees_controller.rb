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
        attendee = User.find(attendee_params['user_id'])
        event = Event.find(attendee_params['event_id'])
        owner = User.find(event.user_id)
        APNS.send_notification(attendee.device_token, "#{owner.full_name} invited you to #{event.title}!") unless attendee.device_token == 'NONE'
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
