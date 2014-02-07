# API Events controller
module Api
  # API Events controller
  module V1
    # API Events controller
    class EventsController < ApplicationController
      respond_to :json

      def index
        respond_with 'Please supply a User Record ID'
      end

      def show
        respond_with User.find(params[:id]).events
      end

      def create
        respond_with Event.new(event_params).save, location: nil
      end

      def update
        event = event.find([:id])
        respond_with event.update(event_params)
      end

      def destroy
        respond_with Event.find(params[:id]).destroy
      end

      def event_params
        params.require(:event).permit(:title, :description, :user_id, :time_of_event)
      end
    end
  end
end
