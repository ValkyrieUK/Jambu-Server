# API Events controller
module Api
  # API Events controller
  module V1
    # API Events controller
    class EventsController < ApiController
      respond_to :json

      def events_attending
        if params[:past]
          events = User.find_by(uid: params[:uid]).attending_events_past
        else
          events = User.find_by(uid: params[:uid]).attending_events_future
        end
        return unless events
        render json: { events: events }
      end

      def show
        respond_with Event.find(params[:id])
      end

      def create
        event = Event.new(event_params)
        if event.save
          render json: { success: true, event_id: event.id }
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
        respond_with event.update(canceled: 'true')
        Activity.create(user_id: event.user_id, action: 'event canceled',
                        name: event.title)
      end

      def event_params
        params.require(:event).permit(:title, :description, :user_id,
                                      :time_of_event, :canceled, :lat,
                                      :long, :time_of_event_end, :privacy,
                                      :location_name)
      end
    end
  end
end
