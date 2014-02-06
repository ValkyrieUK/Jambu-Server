# API Search controller
module Api
# API Search controller
  module V1
    # API Search controller
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
