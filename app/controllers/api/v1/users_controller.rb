# API Users controller
module Api
# API Users controller
  module V1
    # API Users controller
    class UsersController < ApplicationController
      respond_to :json

      def index
        respond_with 'Please provide UID'
      end

      def show
        user = User.find_by_uid(params[:uid])
        render json: { error: 'User does not exist!' } if user.nil?
        return if user.nil?
        create_hash_vars(user)
      end

      def create
        user = User.new(user_params)
        if user.save!
          render json: { success: true }
        else
          render json: { errors: user.errors.full_messages }
        end
      end

      def update
        user = User.find(params[:id])
        user.update(user_params)
        if user.save
          Activity.delay.create(user_id: user.id, action: 'user updated')
          respond_with user
        else
          render json: { errors: user.errors.full_messages }
        end
      end

      def destroy
        user = User.find_by(params[:uid])
        respond_with user.destroy
      end

      def create_hash_vars(user)
        join_event = Event.joins(:attending_users).merge(Attendee.where(user_id: user.id, going?: true))
        next_event = join_event.order(:time_of_event)
        friend_user_id = User.find_by_uid(params[:requestor]).id if params[:requestor]
        friendship_id = Friendship.where(user_id: friend_user_id, friend_id: user.id)
        create_hash(user, join_event, next_event, friend_user_id, friendship_id)
      end

      def create_hash(user, join_event, next_event, friend_user_id, friendship_id)
        user_hash = {
          user: user,
          counts: {
            friends: user.friends.count ,
            added_as_friend: user.inverse_friendships.count,
            events_created: user.events.count,
            events_attended: join_event.count,
            event_invites_pending: join_event.count }
          }
        if friendship_id.any? && friend_user_id
          user_hash.merge!(friend_id: friendship_id.last.id)
        else
          if next_event.empty?
            user_hash.merge!(friend_id: 'NULL')
          else
            user_hash.merge!(friend_id: 'NULL')
            user_hash.merge!(next_event: next_event.first) unless next_event.first == 'over'
          end
        end
        respond_with user_hash
      end

      private

      def user_params
        params.require(:user).permit(:username, :uid, :provider, :image_url,
                                     :image_thumbnail, :full_name, :colour)
      end
    end
  end
end
