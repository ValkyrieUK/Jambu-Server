# BatchAttendeesController
module Api
  # BatchAttendeesController
  module V1
    # BatchAttendeesController
    class BatchAttendeesController < ApplicationController

      def create
        params[:attendees].each do |user_uid|
          user = User.find_by(uid: user_uid.to_s)
          attendee = Attendee.new(user_id: user.id, event_id: params[:event_id])
          attendee.save!
        end
        render json: {response: "okay"}
      end

      private

      def batch_attendees_params
        params.require(:attendees).permit(:attendees, :event_id)
      end
    end
  end
end