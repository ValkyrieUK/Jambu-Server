# API Attendees controller
module Api
  # API Attendees controller
  module V1
    # API Attendees controller
    class AttendeesController < ApplicationController
      respond_to :json

      def show
        respond_with attendees: Event.find(params[:id]).attending_users
      end

      def create
        attendee = Attendee.new(attendee_params)
        if attendee.save
          render json: { success: true }
        else
          render json: { errors: attendee.errors.full_messages }
        end
      end

      def update
        user = User.find_by(uid: params[:uid].to_s)
        attendee = Attendee.where(user_id: user.id, event_id: params[:event_id].to_i)
        respond_with attendee.update(attendee_params)
        if attendee.save
          Activity.create(user_id: user.id, action: 'attendee updated', argument: event.id)
          render json: { success: true }
        end
      end

      def destroy
        respond_with Attendee.find(params[:id]).destroy
      end

      def attendee_params
        params.require(:attendee).permit(:event_id, :user_id, :going?)
      end
    end
  end
end
