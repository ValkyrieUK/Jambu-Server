# BatchAttendeesController
module Api
  # BatchAttendeesController
  module V1
    # BatchAttendeesController
    class BatchAttendeesController < ApplicationController

      def create

      end

      private

      def batch_attendees_params
        params.require(:attendees).permit(:event_id, user: :user_id)
      end
    end
  end
end