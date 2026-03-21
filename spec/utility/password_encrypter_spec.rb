# frozen_string_literal: true

require 'bcrypt'

RSpec.describe Utility::PasswordEncrypter do
  describe '.call' do
    let(:password) { 'test' }

    it 'hashes the password and adds the pepper' do
      hashed_password = described_class.call(password:)
      bcrypt_hash = BCrypt::Password.new(hashed_password)

      expect(bcrypt_hash == "#{password}#{Utility::EnvironmentFetcher.pepper}").to be true
    end
  end
end
