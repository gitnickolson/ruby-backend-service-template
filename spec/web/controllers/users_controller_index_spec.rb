# frozen_string_literal: true

RSpec.describe Web::Controllers::UsersController do
  describe 'GET /users' do
    let(:username) { 'username' }
    let(:mail_address) { 'foo@bar.com' }
    let(:password) { 'bar' }

    let(:other_username) { 'other_username' }
    let(:other_mail_address) { 'bar@baz.com' }
    let(:other_password) { 'baz' }

    let!(:user) { create(:user, username:, mail_address:, password_hash: password) }
    let!(:other_user) do
      create(:user, username: other_username, mail_address: other_mail_address, password_hash: other_password)
    end

    before do
      header('content-type', 'application/json')
      header('host', 'localhost')
    end

    it 'returns a list of serialized users' do
      get('/users')

      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(JSON.generate(data: [{ id: user.id.to_s, username:,
                                                              mailAddress: mail_address,
                                                              createdAt: user.created_at.iso8601 },
                                                            { id: other_user.id.to_s, username: other_username,
                                                              mailAddress: other_mail_address,
                                                              createdAt: other_user.created_at.iso8601 }]))
    end
  end
end
