# frozen_string_literal: true

require 'bcrypt'

module Utility
  class PasswordEncrypter
    class << self
      def call(password:)
        BCrypt::Password.create("#{password}#{Utility::EnvironmentFetcher.pepper}")
      end
    end
  end
end
