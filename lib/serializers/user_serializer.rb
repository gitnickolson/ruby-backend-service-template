# frozen_string_literal: true

module Serializers
  class UserSerializer
    class << self
      def serialize(user:)
        {
          id: user.id.to_s,
          username: user.username,
          mailAddress: user.mail_address,
          createdAt: user.created_at.iso8601
        }
      end

      def serialize_many(users:)
        users.map do |user|
          {
            id: user.id.to_s,
            username: user.username,
            mailAddress: user.mail_address,
            createdAt: user.created_at.iso8601
          }
        end
      end

      def deserialize(payload:)
        {
          username: payload[:username],
          mail_address: payload[:mailAddress],
          password: payload[:password]
        }
      end
    end
  end
end
