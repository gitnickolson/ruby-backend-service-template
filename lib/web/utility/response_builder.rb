# frozen_string_literal: true

module Web
  module Utility
    class ResponseBuilder
      class << self
        def success(payload:, status: 200)
          body = JSON.generate({ data: payload })
          [status, body]
        end

        def error(message:, status:)
          body = JSON.generate({ error: message })
          [status, body]
        end
      end
    end
  end
end
