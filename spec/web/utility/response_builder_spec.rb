# frozen_string_literal: true

RSpec.describe Web::Utility::ResponseBuilder do
  describe '.json_response' do
    let(:payload) { { foo: { bar: 'baz', zip: 'zap' } } }
    let(:status) { 200 }

    it 'returns a json response with the passed payload' do
      result = described_class.json_response(payload:, status:)

      expect(result).to eq([status, "{\"data\":#{JSON.generate(payload)}}"])
    end
  end
end
