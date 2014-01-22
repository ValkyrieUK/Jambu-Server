class UsersController < ApplicationController
  def index
    User.all
  end

  def create
    User.new(params[:user])
  end

  def show
    User.find(parmas[:id])
  end

  def destroy
    User.find(params[:id]).destroy
  end 
end
