# frozen_string_literal: true

module Repositories
  class UserRepository
    class << self
      def all
        Models::User.all
      end

      def create(user_data:)
        password_hash = Utility::PasswordEncrypter.call(password: user_data[:password])

        Models::User.create(username: user_data[:username],
                            mail_address: user_data[:mail_address],
                            password_hash:)
      end

      def mail_taken?(mail_address:)
        Models::User.where(mail_address:).any?
      end

      def username_taken?(username:)
        Models::User.where(username:).any?
      end
    end
  end
end
