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
        new_attendee = Attendee.new(attendee_params)
        attendee = User.find(attendee_params['user_id'])
        event = Event.find(attendee_params['event_id'])
        owner = User.find(event.user_id)
        if new_attendee.save
          respond_with new_attendee, location: nil
          APNS.send_notification(attendee.device_token, "#{owner.full_name} invited you to #{event.title}!") unless attendee.device_token == 'NONE'
        else
          render json: { errors: new_attendee.errors.full_messages }
        end
      end

      def update
        attendee = Attendee.find(params[:id])
        respond_with attendee.update(attendee_params)
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
