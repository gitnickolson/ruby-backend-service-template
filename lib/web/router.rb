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

        map('/api-docs') do
          run proc { |_env|
            path = File.join(__dir__, '..', '..', 'openapi', 'api_docs.yml')
            [200, { 'Content-Type' => 'application/yaml' }, [File.read(path)]]
          }
        end

        map('/') do
          use OpenapiFirst::Middlewares::RequestValidation
          use OpenapiFirst::Middlewares::ResponseValidation

          map('/users') { run Web::Controllers::UsersController }
        end
      end
    end
  end
end
