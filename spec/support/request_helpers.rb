module Requests
  # Json to check if objects params are correct
  module JsonHelpers
    def json
      @json ||= JSON.parse(response.body)
    end
  end
end
