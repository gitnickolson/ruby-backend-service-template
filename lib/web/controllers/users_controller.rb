# frozen_string_literal: true

require 'sinatra'

module Web
  module Controllers
    class UsersController < Sinatra::Base
      before do
        content_type('application/json', charset: 'utf-8')
      end

      post '/' do
        user_data = Serializers::UserSerializer.deserialize(payload:)
        halt 400 unless Validation::UserDataValidator.valid?(user_data:)

        created_user = Repositories::UserRepository.create(user_data:)
        serialized_user = Serializers::UserSerializer.serialize(user: created_user)

        Utility::ResponseBuilder.json_response(payload: serialized_user, status: 201)
      end

      private

      def payload
        JSON.parse(request.body.string, { symbolize_names: true })[:data]
      end
    end
  end
end
