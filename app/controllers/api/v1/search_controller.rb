# API Users controller
module Api
# API Users controller
  module V1
    # API Users controller
    class SearchController < ApplicationController
      respond_to :json

      def index
        respond_with 'Please provide a search term'
      end
      
      def show
        respond_with users: User.search(params[:id])
      end

    end
  end
end