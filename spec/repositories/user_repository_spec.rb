# frozen_string_literal: true

require 'bcrypt'

RSpec.describe Repositories::UserRepository do
  describe '.all' do
    let(:username) { 'nickolson' }
    let(:mail_address) { 'nickolson@example.com' }

    let(:other_username) { 'jackson' }
    let(:other_mail_address) { 'jackson@example.com' }

    let!(:user) do
      create(:user, username:, mail_address:)
    end

    let!(:other_user) do
      create(:user, username: other_username, mail_address: other_mail_address)
    end

    it 'returns all users' do
      result = described_class.all

      expect(result).to eq([user, other_user])
    end
  end

  describe '.create' do
    let(:username) { 'nickolson' }
    let(:mail_address) { 'nickolson@example.com' }
    let(:password) { 'test_password' }
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
      expect(BCrypt::Password.new(Models::User.first.password_hash)).to eq("#{password}#{Utility::EnvironmentFetcher.pepper}")
    end
  end

  describe '.mail_taken?' do
    let(:mail_address) { 'nickolson@example.com' }

    before do
      create(:user, username: 'foo', mail_address:)
    end

    it 'returns true if a user with the passed email exists' do
      expect(described_class.mail_taken?(mail_address:)).to be(true)
    end

    it 'returns false if no user with the passed email exists' do
      expect(described_class.mail_taken?(mail_address: 'foo@bar.com')).to be(false)
    end
  end

  describe '.username_taken?' do
    let(:username) { 'nickolson' }

    before do
      create(:user, username:, mail_address: 'foo')
    end

    it 'returns true if a user with the passed username exists' do
      expect(described_class.username_taken?(username:)).to be(true)
    end

    it 'returns false if no user with the passed username exists' do
      expect(described_class.username_taken?(username: 'bar')).to be(false)
    end
  end
end
