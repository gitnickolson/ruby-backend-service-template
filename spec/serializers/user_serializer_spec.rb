# frozen_string_literal: true

RSpec.describe Serializers::UserSerializer do
  describe '.serialize' do
    let(:user) { create(:user) }

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

  describe '.serialize_many' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user, mail_address: 'test@test.com') }
    let(:users) { [user, other_user] }

    it 'serializes many users' do
      result = described_class.serialize_many(users:)

      expect(result).to eq([{
                             id: user.id.to_s,
                             username: user.username,
                             mailAddress: user.mail_address,
                             createdAt: user.created_at.iso8601
                           },
                            {
                              id: other_user.id.to_s,
                              username: other_user.username,
                              mailAddress: other_user.mail_address,
                              createdAt: other_user.created_at.iso8601
                            }])
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
