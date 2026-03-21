# frozen_string_literal: true

module Serializers
  class UserSerializer
    class << self
      def call(user:)
        {
          id: user.id.to_s,
          username: user.username,
          mailAddress: user.mail_address,
          createdAt: user.created_at.iso8601
        }
      end
    end
  end
end
