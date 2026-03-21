# frozen_string_literal: true

RSpec.describe Serializers::UserSerializer do
  let(:user) { create(:user) }

  describe '.serialize' do
    it 'serializes a user' do
      result = described_class.serialize(user:)

      expect(result).to eq({
                             id: user.id.to_s,
                             username: user.username,
                             mailAddress: user.mail_address,
                             createdAt: user.created_at.iso8601
                           })
    end
  end

  describe '.deserialize' do
    let(:username) { 'foo' }
    let(:mail_address) { 'foo@bar.com' }
    let(:password) { 'baz' }

    let(:payload) do
      {
        username:,
        mailAddress: mail_address,
        password:
      }
    end

    it 'deserializes a user' do
      result = described_class.deserialize(payload:)

      expect(result).to eq({
                             username:,
                             mail_address:,
                             password:
                           })
    end
  end
end
