# API Search controller
module Api
# API Search controller
  module V1
    # API Search controller
    class SearchController < ApiController
      respond_to :json

      def show
        term = params[:id]
        if term.length < 3
          render json: { error: 'Serch Term is less than 3 Chrarcters' }
          return
        end
        if term.length > 80
          render json: { error: 'Serch Term is too long' }
          return
        end
        respond_with users: User.search(term).offset(params[:results]).limit(10)
      end
    end
  end
end
