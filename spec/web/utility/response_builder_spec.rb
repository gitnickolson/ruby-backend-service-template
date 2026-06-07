# frozen_string_literal: true

RSpec.describe Web::Utility::ResponseBuilder do
  describe '.success' do
    let(:payload) { { foo: { bar: 'baz', zip: 'zap' } } }
    let(:status) { 200 }

    it 'returns a json response with the passed payload' do
      result = described_class.success(payload:, status:)

      expect(result).to eq([status, "{\"data\":#{JSON.generate(payload)}}"])
    end
  end

  describe '.error' do
    let(:message) { 'Unprocessable Content' }
    let(:status) { 422 }

    it 'returns a json response with the passed payload' do
      result = described_class.error(message:, status:)

      expect(result).to eq([status, "{\"error\":\"#{message}\"}"])
    end
  end
end
