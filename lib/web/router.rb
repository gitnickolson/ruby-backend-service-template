# frozen_string_literal: true

require 'sinatra/base'

module Web
  class Router
    def initialize
      @app =
        Rack::Builder.app do
          use OpenapiFirst::Middlewares::RequestValidation
          use OpenapiFirst::Middlewares::ResponseValidation

          map('/users') { run Web::Controllers::UsersController }
        end
    end

    def call(env)
      app.call(env)
    end

    private

    attr_reader :app
  end
end
