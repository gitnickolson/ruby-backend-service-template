# frozen_string_literal: true

require 'bcrypt'

RSpec.describe Repositories::UserRepository do
  describe '.create' do
    let(:username) { 'nickolson' }
    let(:mail_address) { 'nickolson@example.com' }
    let(:password) { 'test_password' }
    let(:password_hash) do
      hashed_password = described_class.call(password:)
      BCrypt::Password.new(hashed_password)
    end
    let(:user_data) { { username:, mail_address:, password: } }

    before do
      allow(Utility::PasswordEncrypter).to receive(:call).and_call_original
    end

    it 'creates a user from passed data' do
      described_class.create(user_data:)

      created_user = Models::User.first
      expect(created_user.username).to eq(username)
      expect(created_user.mail_address).to eq(mail_address)
    end

    it 'encrpyts the passed password' do
      described_class.create(user_data:)

      expect(Utility::PasswordEncrypter).to have_received(:call).with(password:)
      expect(BCrypt::Password.new(Models::User.first.password_hash)).to eq("#{password}#{EnvironmentFetcher.pepper}")
    end
  end
end
