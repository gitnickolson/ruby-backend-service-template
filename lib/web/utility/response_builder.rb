# frozen_string_literal: true

module Web
  module Utility
    class ResponseBuilder
      class << self
        def json_response(payload:, status: 200)
          body = JSON.generate({ data: payload })
          [status, body]
        end
      end
    end
  end
end
