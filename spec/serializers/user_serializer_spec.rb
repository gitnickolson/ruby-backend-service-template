# frozen_string_literal: true

RSpec.describe Serializers::UserSerializer do
  let(:user) { create(:user) }

  it 'serializes a user' do
    result = described_class.call(user:)

    expect(result).to eq({
                           id: user.id.to_s,
                           username: user.username,
                           mailAddress: user.mail_address,
                           createdAt: user.created_at.iso8601
                         })
  end
end
