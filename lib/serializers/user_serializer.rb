# frozen_string_literal: true

module Serializers
  class UserSerializer
    class << self
      def call(user:)
        {
          id: user.id.to_s,
          username: user.username,
          mail_address: user.mail_address,
          created_at: user.created_at.iso8601
        }
      end
    end
  end
end
