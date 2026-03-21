# frozen_string_literal: true

require 'sinatra'

module Web
  module Controllers
    class UsersController < Sinatra::Base
      before do
        content_type('application/json', charset: 'utf-8')
      end

      post '/' do
        created_user = Repositories::UserRepository.create(user_data: payload)
        serialized_user = Serializers::UserSerializer.call(user: created_user)

        Utility::ResponseBuilder.json_response(payload: serialized_user, status: 201)
      end

      private

      def payload
        JSON.parse(request.body.string, { symbolize_names: true })[:data]
      end
    end
  end
end
