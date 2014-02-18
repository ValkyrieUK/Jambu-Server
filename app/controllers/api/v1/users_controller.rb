# API Users controller
module Api
# API Users controller
  module V1
    # API Users controller
    class UsersController < ApplicationController
      respond_to :json

      def index
        respond_with 'Please provide a UID'
      end

      def show
        user = User.find_by_uid(params[:uid])
        user_hash = {
          user: user,
          counts: {
            friends: user.friends.count ,
            added_as_friend: User.joins(:friendships).merge(Friendship.where(friend_id: user.id)).count,
            events_created: user.events.count,
            events_attended: Event.joins(:attending_users).merge(Attendee.where(user_id: user.id, going?: true)).count,
            event_invites_pending: 0 }
        }
        respond_with user_hash
      end

      def create
        user = User.find_or_create_by(user_params)
        if user.save
          respond_with user, location: nil
        else
          render json: { errors: user.errors.full_messages }
        end
      end

      def update
        user = User.find(params[:id])
        user.update(user_params)
        if user.save
          respond_with user
        else
          render json: { errors: user.errors.full_messages }
        end
      end

      def destroy
        respond_with User.find_by(params[:uid]).destroy
      end

      private

      def user_params
        params.require(:user).permit(:username, :uid, :provider, :image_url, :image_thumbnail, :full_name, :colour)
      end
    end
  end
end
