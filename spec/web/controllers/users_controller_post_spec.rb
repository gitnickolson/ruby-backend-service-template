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
                        mailAddress: mail_address,
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
                                                         mailAddress: mail_address,
                                                         verified: user.verified,
                                                         createdAt: user.created_at.iso8601
                                                       }
                                                     }))
    end

    it 'creates a user with unverified status' do
      post('/users', body)

      expect(last_response.status).to eq(201)

      user = Models::User.first
      expect(user).to have_attributes({
                                        verified: false
                                      })
    end

    context 'when user with same email already exists' do
      before do
        create(:user, username: 'foo', mail_address:, password_hash: password)
      end

      it 'returns 409' do
        post('/users', body)

        expect(last_response.status).to eq(409)
      end
    end

    context 'when user with same username already exists' do
      before do
        create(:user, username:, mail_address: 'foo', password_hash: password)
      end

      it 'returns 409' do
        post('/users', body)

        expect(last_response.status).to eq(409)
      end
    end

    context 'when email does not match email format' do
      let(:mail_address) { 'foobarbaz' }

      it 'returns 400' do
        post('/users', body)

        expect(last_response.status).to eq(400)
      end
    end

    context 'when username is too long' do
      let(:username) { '123456789_123456789_1' }

      it 'returns 400' do
        post('/users', body)

        expect(last_response.status).to eq(400)
      end
    end

    context 'when email is too long' do
      let(:mail_address) do
        "this_is_a_very_long_email_this_is_a_very_long_email_this_is_a_very_long_email\n" \
          '@very_long_email_very_long_email.com'
      end

      it 'returns 400' do
        post('/users', body)

        expect(last_response.status).to eq(400)
      end
    end

    context 'when password is too long' do
      let(:password) { 'thisisaverylongpassworditisinfacttoolong' }

      it 'returns 400' do
        post('/users', body)

        expect(last_response.status).to eq(400)
      end
    end

    context 'when username does not match required format' do
      let(:username) { '={}aqwe;\"' }

      it 'returns 422' do
        post('/users', body)

        expect(last_response.status).to eq(422)
      end
    end
  end
end
