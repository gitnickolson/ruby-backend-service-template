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

        result = Validation::UserDataValidator.validate(user_data:)
        halt(Utility::ResponseBuilder.error(message: result.value, status: 422)) if result.failure?

        halt(Utility::ResponseBuilder.error(message: 'Username taken.', status: 409)) if username_taken?(user_data)
        halt(Utility::ResponseBuilder.error(message: 'Mail address taken.', status: 409)) if mail_taken?(user_data)

        created_user = Repositories::UserRepository.create(user_data:)
        serialized_user = Serializers::UserSerializer.serialize(user: created_user)

        Utility::ResponseBuilder.success(payload: serialized_user, status: 201)
      end

      get '/' do
        users = Repositories::UserRepository.all
        serialized_users = Serializers::UserSerializer.serialize_many(users:)

        Utility::ResponseBuilder.success(payload: serialized_users, status: 200)
      end

      private

      def username_taken?(user_data)
        Repositories::UserRepository.username_taken?(username: user_data[:username])
      end

      def mail_taken?(user_data)
        Repositories::UserRepository.mail_taken?(mail_address: user_data[:mail_address])
      end

      def payload
        JSON.parse(request.body.string, { symbolize_names: true })[:data]
      end
    end
  end
end
