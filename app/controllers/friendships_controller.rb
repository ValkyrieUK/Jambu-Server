class FriendshipsController < ApplicationController
  
  def index
    Friendship.all
  end

  def show
    Friendship.find(params[:id])
  end

  def create
    Friendship.new(params[:friendship])
  end

  def destroy
    Friendship.destroy(params[:id])
  end
end

