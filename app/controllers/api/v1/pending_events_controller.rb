# API Events controller
module Api
  # API Events controller
  module V1
    # API Events controller
    class PendingEventsController < ApiController
      respond_to :json

      def show
        user = User.find_by(uid: params[:id])
        return unless user
        events = user.pending_invites
        render json: { events: events }
      end
    end
  end
end
