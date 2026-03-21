# frozen_string_literal: true

module Repositories
  class UserRepository
    class << self
      def create(user_data:)
        password_hash = Utility::PasswordEncrypter.call(password: user_data[:password])

        Models::User.create(username: user_data[:username],
                            mail_address: user_data[:mail_address],
                            password_hash:)
      end
    end
  end
end
