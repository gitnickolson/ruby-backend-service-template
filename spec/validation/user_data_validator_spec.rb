# frozen_string_literal: true

RSpec.describe Validation::UserDataValidator do
  describe '.validate' do
    let(:username) { 'username' }
    let(:mail_address) { 'foo@bar.com' }
    let(:password) { 'bar' }
    let(:user_data) do
      {
        username:,
        mail_address: mail_address,
        password:
      }
    end

    it 'returns an ok result when data is valid' do
      expect(described_class.validate(user_data:)).to have_attributes(ok?: true)
    end

    context 'when username contains invalid characters' do
      ['user name', 'user-name', 'user.name', 'user()name', 'user<>name', 'user@name', 'username!'].each do |name|
        let(:username) { name }

        it 'returns a failure result' do
          expect(described_class.validate(user_data:)).to have_attributes(
            ok?: false,
            value: 'Username malformed'
          )
        end
      end
    end

    context 'when username is too long' do
      let(:username) { '123456789_123456789_1' }

      it 'returns a failure result' do
        expect(described_class.validate(user_data:)).to have_attributes(
          ok?: false,
          value: 'Username malformed'
        )
      end
    end

    context 'when username is nil' do
      let(:username) { nil }

      it 'returns a failure result' do
        expect(described_class.validate(user_data:)).to have_attributes(
          ok?: false,
          value: 'Username malformed'
        )
      end
    end

    context 'when password is too long' do
      let(:password) { '123456789_123456789_123456789_1' }

      it 'returns a failure result' do
        expect(described_class.validate(user_data:)).to have_attributes(
          ok?: false,
          value: 'Password malformed'
        )
      end
    end

    context 'when password is nil' do
      let(:password) { nil }

      it 'returns a failure result' do
        expect(described_class.validate(user_data:)).to have_attributes(
          ok?: false,
          value: 'Password malformed'
        )
      end
    end

    context 'when email is too long' do
      let(:mail_address) do
        "this_is_a_very_long_email_this_is_a_very_long_email_this_is_a_very_long_email\n" \
          '@very_long_email_very_long_email.com'
      end

      it 'returns a failure result' do
        expect(described_class.validate(user_data:)).to have_attributes(
          ok?: false,
          value: 'Mail address malformed'
        )
      end
    end

    context 'when email is nil' do
      let(:mail_address) { nil }

      it 'returns a failure result' do
        expect(described_class.validate(user_data:)).to have_attributes(
          ok?: false,
          value: 'Mail address malformed'
        )
      end
    end
  end
end
