# frozen_string_literal: true

module Validation
  class UserDataValidator
    class << self
      def valid?(user_data:)
        username_valid?(user_data[:username]) &&
          mail_address_valid?(user_data[:mail_address]) &&
          password_valid?(user_data[:password])
      end

      private

      def username_valid?(username)
        return false if username.nil?
        return false if username.length > 20

        /\A[a-z0-9_]{4,16}\z/.match?(username)
      end

      def mail_address_valid?(mail_address)
        return false if mail_address.nil?
        return false if mail_address.length > 100

        true
      end

      def password_valid?(password)
        return false if password.nil?
        return false if password.length > 30

        true
      end
    end
  end
end
