# frozen_string_literal: true

require 'rack/cors'
require 'sinatra/base'

module Web
  class Router
    def initialize
      @app = initialize_app
    end

    def call(env)
      app.call(env)
    end

    private

    attr_reader :app

    def initialize_app # rubocop:disable Metrics/MethodLength
      Rack::Builder.app do
        use Rack::Cors do
          allow do
            origins 'http://localhost:3000'
            resource '*',
                     headers: :any,
                     methods: %i[get post put delete options]
          end
        end

        use OpenapiFirst::Middlewares::RequestValidation
        use OpenapiFirst::Middlewares::ResponseValidation

        map('/users') { run Web::Controllers::UsersController }
      end
    end
  end
end
