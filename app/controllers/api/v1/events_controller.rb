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
        respond_with Event.find(params[:id])
      end

      def create
        event = Event.new(event_params)
        if event.save
          render json: { success: true }
        else
          render json: { errors: event.errors.full_messages }
        end
      end

      def update
        event = Event.find(params[:id])
        event.update(event_params)
        if event.save
          respond_with event
        else
          render json: { errors: event.errors.full_messages }
        end
      end

      def destroy
        event = Event.find(params[:id])
        respond_with event.update(canceled?: true)
        Activity.where(user_id: event.user_id, action: 'event created',
                       name: event.title).last.destroy
      end

      def event_params
        params.require(:event).permit(:title, :description, :user_id, :time_of_event, :canceled?)
      end
    end
  end
end
