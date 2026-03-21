# frozen_string_literal: true

RSpec.describe Web::Controllers::UsersController do
  describe 'POST /users' do
    let(:username) { 'username' }
    let(:mail_address) { 'foo@bar.com' }
    let(:password) { 'bar' }

    let(:body) do
      JSON.generate({
                      data: {
                        username:,
                        mail_address:,
                        password:
                      }
                    })
    end

    before do
      header('content-type', 'application/json')
      header('host', 'localhost')
    end

    it 'creates a user' do
      post('/users', body)

      expect(last_response.status).to eq(201)

      user = Models::User.first
      expect(user).to have_attributes({
                                        username:,
                                        mail_address:
                                      })

      expect(BCrypt::Password.new(user.password_hash)).to eq("#{password}#{Utility::EnvironmentFetcher.pepper}")
    end

    it 'returns the created user' do
      post('/users', body)

      user = Models::User.first
      expect(last_response.status).to eq(201)
      expect(last_response.body).to eq(JSON.generate({
                                                       data: {
                                                         id: user.id.to_s,
                                                         username:,
                                                         mail_address:,
                                                         created_at: user.created_at.iso8601
                                                       }
                                                     }))
    end

    context 'with missing required parameters' do
      let(:body) do
        JSON.generate({
                        data: {
                          username:,
                          mail_address:
                        }
                      })
      end

      it 'returns 400' do
        post('/users', body)

        expect(last_response.status).to eq(400)
      end
    end
  end
end
