# frozen_string_literal: true

require 'bcrypt'

module Utility
  class PasswordEncrypter
    class << self
      def call(password:)
        BCrypt::Password.create("#{password}#{EnvironmentFetcher.pepper}")
      end
    end
  end
end
